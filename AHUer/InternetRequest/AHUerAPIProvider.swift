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
    
    static func asyncRequest(_ target: AHUerAPI) async throws -> JSON {
        return try await withCheckedThrowingContinuation{ continuation in
            provider.request(target) { result in
                switch result {
                case .success(let respon):
                    if let analysis = try? JSON(data: respon.data){
                        let msg = analysis["msg"].stringValue
                        if analysis["success"].boolValue {
                            continuation.resume(returning: analysis)
                        }else{
                            continuation.resume(throwing: AHUerAPIError(code: analysis["code"].int ?? -10, title: target.errorHandelTitle, message: msg))
                        }
                    }else{
                        continuation.resume(throwing: AHUerAPIError(code: -10, title: target.errorHandelTitle))
                    }
                case .failure(let error):
                    continuation.resume(throwing: AHUerAPIError(code: error.errorCode, title: target.errorHandelTitle, message: error.localizedDescription))
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
    
    static var backgroundContext: NSManagedObjectContext = PersistenceController.shared.container.newBackgroundContext()

    
    /// 网络请求登录（Async版）
    /// - Parameters:
    ///   - userId: 用户ID
    ///   - password: 密码
    ///   - type: 登录目标
    /// - Returns: 是否成功
    @discardableResult
    static func loggin(userId: String, password: String, type: Int) async throws -> String? {
        print(Thread.current)
        let respon = try await asyncRequest(.login(userId: userId, password: password, type: type))
        
        guard respon["success"].boolValue,
              let userName = respon["data"]["name"].string
        else { throw AHUerAPIError(code: -10, title: "登录失败") }
        
        //cookie存储
        HTTPCookieStorage.saveAHUerCookie()
        
        let attribute = JSON(["studentID" : userId, "studentName" : userName])
        print(Thread.current)

        container.performBackgroundTask { context in
            if let user = Student.fetch(studentId: userId, in: context) {
                user.update(of: attribute)
            } else {
                Student.insert(in: context)?.update(of: attribute)
            }
        }
        
        return userName
    }
    
    
    
    /// 网络请求课表
    /// - Parameters:
    ///   - schoolYear: 学年
    ///   - schoolTerm: 学期
    /// - Returns: 请求结果
    /// 此函数的返回的时候coredata很可能还未存储
    static func getSchedule(schoolYear: String, schoolTerm: Int) async throws{
        let respon = try await asyncRequest(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm))
        
        guard respon["success"].boolValue else { return }
        let schedules = respon["data"]
        
        backgroundContext.performAndWait {
            let user = Student.nowUser(in: backgroundContext)
            user?.updataCourses(courses: Course.pack(attributes: schedules.arrayValue, in: backgroundContext))
        }
        
    }
    

    /// 网络请求成绩
    /// Term --- Grade-----Gpa
    /// - Returns: 请求结果
    static func getScore() async throws{
        let respon: JSON = try await asyncRequest(.grade)
        let grades = respon["data"]
        
        container.performBackgroundTask { context in
            guard let user = Student.nowUser(in: context)?.update(of: grades) else { return }
            
            let termGradeLists = grades["termGradeList"].arrayValue
            
            for term in termGradeLists{
                //清空原有的数据
                Grade.fetch(schoolYear: term["schoolYear"].stringValue, schoolTerm: term["schoolTerm"].stringValue, in: context)?.forEach({$0.delete()})
                Grade.insert(in: context)?.update(of: term)?.beHold(of: user)?.addToGpas(GPA.pack(attributes: term["termGradeList"].arrayValue, in: context))
            }
        }
    }
    
    /// 请求考试信息
    /// - Parameters:
    ///   - year: 年
    ///   - term: 学期
    static func getExamination(year: String, term: Int) async throws{
        let respon = try await asyncRequest(.examInfo(schoolYear: year, schoolTerm: term))
        
        container.performBackgroundTask { context in
            guard let user = Student.nowUser(in: context) else { return }
            let exams = respon["data"].arrayValue.reduce([JSON]()) { partialResult, json in
                var exam = json.dictionaryValue
                exam.updateValue(JSON(year), forKey: "schoolYear")
                exam.updateValue(JSON(term), forKey: "schoolTerm")
                return partialResult + [JSON(exam)]
            }
            user.updataCourses(courses: Exam.pack(attributes: exams, in: context))
        }
    }
    
    /// 网络登出
    static func logout(type: Int = 1) async throws{
        let _ = try await asyncRequest(.logout(type: type))
        container.performBackgroundTask { context in
            guard let student = Student.nowUser(in: context) else { return }
            student.delete()
        }
        HTTPCookieStorage.deleteAHUerCookie()
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
