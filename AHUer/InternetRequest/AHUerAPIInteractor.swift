//
//  AHUerAPIInteractor.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/20.
//

import Foundation
import Moya
import CoreData

/// AHUerAPI容器
struct AHUerAPIInteractor{
    private static let provider = MoyaProvider<AHUerAPI>(plugins: [AHUerAlertPlugin()])

    
    @available(*, deprecated, message: "Perfer async alternative instead")
    static func netRequest(_ target: AHUerAPI,
                           success successCallback: @escaping (_ respon: [String:Any]?) -> Void,
                           error errorCallBack: @escaping (_ error: AHUerAPIError) -> Void)
    {
        provider.request(target) { result in
            switch result {
            case .success(let respon):
                if let analysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
                    let msg = analysis["msg"] as? String
                    if let status = analysis["success"] as? Bool, status == true {
                        successCallback(analysis)
                    }else{
                        errorCallBack(AHUerAPIError(code: analysis["code"] as? Int ?? -10, title: target.errorHandelTitle, message: msg))
                    }
                }else{
                    errorCallBack(AHUerAPIError(code: -10, title: target.errorHandelTitle))
                }
            case .failure(let error):
                errorCallBack(AHUerAPIError(code: error.errorCode, title: target.errorHandelTitle, message: error.localizedDescription))
            }
        }
    }
    
    
    static func asyncRequest(_ target: AHUerAPI) async throws -> [String:Any]? {
        do {
            return try await withCheckedThrowingContinuation{ continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let respon):
                        if let analysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
                            let msg = analysis["msg"] as? String
                            if let status = analysis["success"] as? Bool, status == true {
                                continuation.resume(returning: analysis)
                            }else{
                                continuation.resume(throwing: AHUerAPIError(code: analysis["code"] as? Int ?? -10, title: target.errorHandelTitle, message: msg))
                            }
                        }else{
                            continuation.resume(throwing: AHUerAPIError(code: -10, title: target.errorHandelTitle))
                        }
                    case .failure(let error):
                        continuation.resume(throwing: AHUerAPIError(code: error.errorCode, title: target.errorHandelTitle, message: error.localizedDescription))
                    }
                }
            }
        } catch {
            throw error
        }
    }
}



// 一些操作的包装
extension AHUerAPIInteractor{
    
   
    /// 网络请求登录（Async版）
    /// - Parameters:
    ///   - userId: 用户ID
    ///   - password: 密码
    ///   - type: 登录目标
    /// - Returns: 是否成功
    @discardableResult
    static func loggin(userId: String, password: String, type: Int) async throws -> Bool {
        
        
        let respon =  try await asyncRequest(.login(userId: userId, password: password, type: type))
        
        guard let statusNum = respon?["success"] as? Bool, statusNum == true,
              let data = respon?["data"] as? [String: Any],
              let userName = data["name"] as? String else { return false }
        //cookie存储
        HTTPCookieStorage.saveAHUerCookie()
        
        guard let users = Student.fetch(studentId: userId) else {return false}
        
        if users.isEmpty{
            Student.insert()?.update(of: ["studentID": userId, "studentName": userName])
        }else{
            users.forEach {$0.update(of: ["studentID" : userId, "studentName" : userName])}
        }
        return true
    }
    
    
    
    /// 网络请求课表
    /// - Parameters:
    ///   - schoolYear: 学年
    ///   - schoolTerm: 学期
    /// - Returns: 请求结果
    @discardableResult
    static func getSchedule(schoolYear: String, schoolTerm: Int) async throws -> Bool{
        guard let respon = try await asyncRequest(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)),
              let statusNum = respon["success"] as? Bool, statusNum == true,
              let schedules = respon["data"] as? [[String: Any]],
              let user = Student.nowUser()
        else { return false }
        user.updataCourses(courses: Course.inserts(courses: schedules))
        return true
    }
    

    /// 网络请求成绩
    /// Term --- Grade-----Gpa
    /// - Returns: 请求结果
    @discardableResult
    static func getScore() async throws -> Bool{
        
        let respon = try await asyncRequest(.grade)
        
        guard let grades = respon?["data"] as? [String: Any],
              let user = Student.nowUser()?.update(of: grades),
              let termGradeLists = grades["termGradeList"] as? [[String:Any?]] else { return false }
        
        for term in termGradeLists{
            guard let gpas = term["termGradeList"] as? [[String:Any]?], let schoolYear = term["schoolYear"] as? String, let schoolTerm = term["schoolTerm"] as? String else {continue}
            
            //清空原有的数据
            Grade.fetch(schoolYear: schoolYear, schoolTerm: schoolTerm)?.forEach({$0.delete()})
            Grade.insert()?.update(of: term)?.beHold(of: user).addToGpas(GPA.inserts(gpas: gpas))
        }
        return true
    }
    
    /// 请求考试信息
    /// - Parameters:
    ///   - year: 年
    ///   - term: 学期
    /// - Returns: 请求结果
    @discardableResult
    static func getExamination(year: String, term: Int) async throws -> Bool{
        let respon = try await asyncRequest(.examInfo(schoolYear: year, schoolTerm: term))
        guard let exams = respon?["data"] as? [[String: Any]] ,
              let user = Student.nowUser() else { return false }
        
        user.updataExams(exams: Exam.inserts(exmas: exams.map({
            var examAttribute = $0
            examAttribute.updateValue(year, forKey: "schoolYear")
            examAttribute.updateValue(term, forKey: "schoolTerm")
            return examAttribute
        })))
        return true
    }
    
    /// 网络登出
    @discardableResult
    static func logout(type: Int = 1) async throws -> Bool{
        let _ = try await asyncRequest(.logout(type: type))
        guard let student = Student.nowUser() else { return false}
        student.delete()
        HTTPCookieStorage.deleteAHUerCookie()
        return true
    }
    
}
