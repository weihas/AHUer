//
//  AhuerAPIProvider.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/20.
//

import Foundation
import Moya
import CoreData

/// AHUerAPI容器
struct AhuerAPIProvider{
    private static let provider = MoyaProvider<AHUerAPI>(plugins: [AHUerAlertPlugin()])

    
    
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
                        errorCallBack(AHUerAPIError(code: analysis["code"] as? Int ?? -10, message: msg))
                    }
                }else{
                    errorCallBack(AHUerAPIError(code: -10))
                }
            case .failure(let error):
                errorCallBack(AHUerAPIError(code: error.errorCode, message: error.localizedDescription))
            }
        }
    }
}



// 一些操作的包装
extension AhuerAPIProvider{
    typealias success =  () -> Void
    typealias error = (_ error: AHUerAPIError) -> Void
    /// 网络请求登录
    /// - Parameters:
    static func loggin(userId: String, password: String, type: Int, successCallback: @escaping success, errorCallback: @escaping error) {
        AhuerAPIProvider.netRequest(.login(userId: userId, password: password, type: type)) { respon in
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let data = respon?["data"] as? [String: Any]{
                let userName = data["name"] as? String
                //cookie存储
                HTTPCookieStorage.saveAHUerCookie()
                guard let result = Student.fetch(studentId: userId) else {return}
                if result.isEmpty{
                    Student.insert()?.update(of: ["studentID": userId, "studentName": userName])
                }else{
                    result.forEach {$0.update(of: ["studentID" : userId, "studentName" : userName])}
                }
                successCallback()
            }
        } error: { error in
            errorCallback(error)
        }
    }
    
    /// 网络请求课表
    static func getSchedule(schoolYear: String, schoolTerm: Int, successCallback: @escaping success, errorCallback: @escaping error){
        AhuerAPIProvider.netRequest(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)) { respon in
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let schedules = respon?["data"] as? [[String: Any]]{
                guard let user = Student.nowUser() else {return}
                user.updataCourses(courses: Course.inserts(courses: schedules))
                successCallback()
            }
        } error: { error in
            errorCallback(error)
        }
    }
    
    ///网络请求成绩
    ///Term --- Grade-----Gpa
    static func getScore(successCallback: @escaping success, errorCallback: @escaping error){
        AhuerAPIProvider.netRequest(.grade) { respon in
            if let grades = respon?["data"] as? [String: Any]{
                guard let user = Student.nowUser()?.update(of: grades) else {return}
                guard let termGradeLists = grades["termGradeList"] as? [[String:Any?]] else {return}
                for term in termGradeLists{
                    guard let gpas = term["termGradeList"] as? [[String:Any]?], let schoolYear = term["schoolYear"] as? String, let schoolTerm = term["schoolTerm"] as? String else {continue}
                    
                    //清空原有的数据
                    Grade.fetch(schoolYear: schoolYear, schoolTerm: schoolTerm)?.forEach({$0.delete()})
                    
                    Grade.insert()?.update(of: term)?.beHold(of: user).addToGpas(GPA.inserts(gpas: gpas))
                }
                successCallback()
            }
        } error: { error in
            errorCallback(error)
        }
    }
    
    /// 网络请求考场
    static func getExamination(year: String, term: Int, successCallback: @escaping success, errorCallback: @escaping error){
        AhuerAPIProvider.netRequest(.examInfo(schoolYear: year, schoolTerm: term)) { respon in
            if let exams = respon?["data"] as? [[String: Any]]{
                guard let user = Student.nowUser() else {return}

                user.updataExams(exams: Exam.inserts(exmas: exams.map({
                    var examAttribute = $0
                    examAttribute.updateValue(year, forKey: "schoolYear")
                    examAttribute.updateValue(term, forKey: "schoolTerm")
                    return examAttribute
                })))
                successCallback()
            }
        } error: { error in
            errorCallback(error)
        }
    }
    
    /// 网络登出
    static func logout(type: Int = 1, successCallback: @escaping success, errorCallback: @escaping error){
        AhuerAPIProvider.netRequest(.logout(type: type)) { respon in
            guard let student = Student.nowUser() else { return }
            student.delete()
            HTTPCookieStorage.deleteAHUerCookie()
            successCallback()
        } error: { error in
            errorCallback(error)
        }
    }
    
}
