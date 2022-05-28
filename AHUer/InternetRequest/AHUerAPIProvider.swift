//
//  AHUerAPIProvider.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/20.
//

import Foundation
import Moya
import CoreData
import SwiftyJSON

/// AHUerAPI容器
struct AHUerAPIProvider{
    private static let provider = MoyaProvider<AHUerAPI>(plugins: [AHUerAlertPlugin()])
    
    private init(){}
    
    static func asyncRequest(_ target: AHUerAPI) async throws -> JSON {
        return try await withCheckedThrowingContinuation{ continuation in
            provider.request(target) { result in
                switch result {
                case .success(let respon):
                    //如果JSON序列化失败直接抛出错误
                    guard let analysis = try? JSON(data: respon.data) else {
                        continuation.resume(throwing: AHUerAPIError(code: -10, title: target.errorHandelTitle))
                        return
                    }
                    //如果分析结果["success"]为真
                    if analysis["success"].boolValue {
                        //返回JSON
                        continuation.resume(returning: analysis)
                    } else {
                        //抛出错误
                        continuation.resume(throwing: AHUerAPIError(code: analysis["code"].int ?? -10, title: target.errorHandelTitle, message: analysis["msg"].stringValue))
                    }
                    
                case .failure(let error):
                    continuation.resume(throwing: AHUerAPIError(code: error.errorCode, title: target.errorHandelTitle, message: error.errorDescription))
                }
            }
        }
    }
}



// 一些操作的包装
extension AHUerAPIProvider{
    
    //CoreData 容器
    static var container: NSPersistentContainer{
        return PersistenceController.shared.container
    }

    /// 网络请求登录（Async版）
    /// - Parameters:
    ///   - userId: 用户ID
    ///   - password: 密码
    ///   - type: 登录目标
    /// - Returns: 用户名(不为空则成功)
    static func loggin(userId: String, password: String, type: Int, saveCookie: Bool) async throws {
        let respon: JSON = try await asyncRequest(.login(userId: userId, password: password, type: type))
        
        guard let userName = respon["data"]["name"].string, userName != "" else { throw AHUerAPIError(code: -10, title: "登录") }
        
        if saveCookie {
            //cookie存储
            HTTPCookieStorage.saveAHUerCookie()
        }
        
        let attribute = JSON(["studentID" : userId, "studentName" : userName])

        await container.performBackgroundTask { context in
            if let user = Student.fetch(studentId: userId, in: context) {
                user.update(of: attribute)
            } else {
                Student.insert(in: context)?.update(of: attribute)
            }
        }
    }
    
    
    
    /// 网络请求课表
    /// - Parameters:
    ///   - schoolYear: 学年
    ///   - schoolTerm: 学期
    /// - Returns: 请求结果
    /// 此函数的返回的时候coredata很可能还未存储
    static func getSchedule(schoolYear: String, schoolTerm: Int) async throws{
        let respon: JSON = try await asyncRequest(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm))
        
        let schedules = respon["data"].arrayValue
        
        let backgroundContext = container.newBackgroundContext()
        
        backgroundContext.performAndWait {
            let user = Student.nowUser(in: backgroundContext)
            user?.updataCourses(courses: Course.pack(attributes: schedules, in: backgroundContext))
        }
        
    }
    

    /// 网络请求成绩
    /// - Returns: 请求结果
    static func getScore() async throws{
        let respon: JSON = try await asyncRequest(.grade)
        let grades = respon["data"]
        
        let backgroundContext = container.newBackgroundContext()
        
        backgroundContext.performAndWait {
            guard let user = Student.nowUser(in: backgroundContext) else { return }
            user.totalGradePoint = grades["totalGradePoint"].doubleValue
            user.totalCredit = grades["totalCredit"].doubleValue
            user.totalGradePointAverage = grades["totalGradePointAverage"].doubleValue
            
            
            for termGrade in grades["termGradeList"].arrayValue {
                guard let year = termGrade["schoolYear"].string, let term = termGrade["schoolTerm"].string else { continue }
                
                if year == Date().studyYear, term == "\(Date().studyTerm)" {
                    user.termGradePoint = termGrade["termGradePointAverage"].doubleValue
                }
                //清空原有的数据
                Grade.fetch(schoolYear: year, schoolTerm: term, in: backgroundContext)?.forEach({$0.delete()})
                
                for grade in termGrade["termGradeList"].arrayValue {
                    guard var insertGrade = grade.dictionaryObject else { continue }
                    insertGrade.updateValue(year, forKey: "schoolYear")
                    insertGrade.updateValue(term, forKey: "schoolTerm")
                    Grade.insert(in: backgroundContext)?.update(of: insertGrade)?.beHold(of: user)
                }
                
                
            }
        }
    }
    
    /// 请求考试信息
    /// - Parameters:
    ///   - year: 年
    ///   - term: 学期
    static func getExamination(year: String, term: Int) async throws{
        let respon: JSON = try await asyncRequest(.examInfo(schoolYear: year, schoolTerm: term))
        
        let backgroundContext = container.newBackgroundContext()
        
        backgroundContext.performAndWait {
            guard let user = Student.nowUser(in: backgroundContext) else { return }
            let exams = respon["data"].arrayValue.reduce([JSON]()) { partialResult, json in
                var exam = json.dictionaryValue
                exam.updateValue(JSON(year), forKey: "schoolYear")
                exam.updateValue(JSON(term), forKey: "schoolTerm")
                return partialResult + [JSON(exam)]
            }
            user.updataExams(exams: Exam.pack(attributes: exams, in: backgroundContext))
        }
    }
    
    /// 网络登出
    static func logout(type: Int = 1) async {
        let _ = try? await asyncRequest(.logout(type: type))
        
        await container.performBackgroundTask { context in
            guard let student = Student.nowUser(in: context) else { return }
            student.delete()
        }
        HTTPCookieStorage.deleteAHUerCookie()
        UserDefaults.standard.removeObject(forKey: AHUerDefaultsKey.AHUID.rawValue)
    }
    
    
    /// 浴室
    static func bathroom() async throws{
        let respon: JSON = try await asyncRequest(.bathroom)
        let rooms = respon["data"].arrayValue
        for room in rooms {
            guard let roomName = room["bathroom"].string ,
                  let roomStatus = room["openStatus"].string ,
                  let bathroom = BathRoom(name: roomName) else { continue }
            UserDefaults.standard.set(roomStatus, forKey: bathroom.defaultsKey)
        }
        
//        UserDefaults.standard.set(respon["data"], forKey: AHUerDefaultsKey.BathRoom.rawValue)
    }
    
    /// 余额
    static func cardBalance() async throws{
        let respon: JSON = try await asyncRequest(.campusCardBalance)
        await container.performBackgroundTask { context in
            guard let student = Student.nowUser(in: context) else { return }
            student.cardBalance = respon["data"]["balance"].doubleValue
        }
    }
}








//    @available(*, deprecated, message: "Perfer async alternative instead")
//    static func netRequest(_ target: AHUerAPI,
//                           success successCallback: @escaping (_ respon: [String:Any]?) -> Void,
//                           error errorCallBack: @escaping (_ error: AHUerAPIError) -> Void)
//    {
//        provider.request(target) { result in
//            switch result {
//            case .success(let respon):
//                if let analysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
//                    let msg = analysis["msg"] as? String
//                    if let status = analysis["success"] as? Bool, status == true {
//                        successCallback(analysis)
//                    }else{
//                        errorCallBack(AHUerAPIError(code: analysis["code"] as? Int ?? -10, title: target.errorHandelTitle, message: msg))
//                    }
//                }else{
//                    errorCallBack(AHUerAPIError(code: -10, title: target.errorHandelTitle))
//                }
//            case .failure(let error):
//                errorCallBack(AHUerAPIError(code: error.errorCode, title: target.errorHandelTitle, message: error.localizedDescription))
//            }
//        }
//    }
//
