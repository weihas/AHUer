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
    typealias successCallback = (_ respon: [String:Any]?) -> Void
    typealias errorCallBack =  (_ statusCode: Int, _ message: String) -> Void
    typealias failureCallBack =  (_ falilure: MoyaError) ->Void
    
    
    static func netRequest(_ target: AHUerAPI,
                           success successCallback: @escaping successCallback,
                           error errorCallBack: @escaping errorCallBack,
                           failure failureCallBack: @escaping failureCallBack)
    {
        provider.request(target) { result in
            switch result {
            case .success(let respon):
                if let analysis = try? respon.mapJSON(failsOnEmptyData: true) as? [String:Any]{
                    let msg = analysis["msg"] as? String ?? ""
                    if let status = analysis["success"] as? Bool, status == true {
                        successCallback(analysis)
                    }else{
                        errorCallBack(analysis["code"] as? Int ?? -3, msg)
                    }
                }else{
                    errorCallBack(-10, "JSON解析失败")
                }
            case .failure(let error):
                failureCallBack(error)
            }
        }
    }
}



// 一些操作的包装
extension AhuerAPIProvider{
    typealias successNotify = () -> Void
    /// 网络请求登录
    /// - Parameters:
    static func loggin(userId: String, password: String, type: Int, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack) {
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
                successNotify()
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { falilure in
            errorCallBack(-1 , "错误")
        }
    }
    
    /// 网络请求课表
    static func getSchedule(schoolYear: String, schoolTerm: Int, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)) { respon in
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let schedules = respon?["data"] as? [[String: Any]]{
                guard let user = Student.nowUser() else {return}
                for schedule in schedules{
                    guard let scheduleId = schedule["courseId"] as? String, let result = Course.fetch(by: NSPredicate(format: "owner = %@ AND courseId = %@", user, scheduleId)) else {continue}
                    if result.isEmpty{
                        Course.insert()?.update(of: schedule)?.beHolded(by: user)
                    }else{
                        result.forEach({$0.update(of: schedule)})
                    }
                }
                successNotify()
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { falilure in
            errorCallBack(-1 , "错误")
        }
    }
    
    ///网络请求成绩
    ///Term --- Grade-----Gpa
    static func getScore(success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
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
                successNotify()
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { falilure in
            errorCallBack(-1 , "错误")
        }
    }
    
    /// 网络请求考场
    static func getExamination(year: String, term: Int, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.examInfo(schoolYear: year, schoolTerm: term)) { respon in
            if let exams = respon?["data"] as? [[String: Any]]{
                guard let user = Student.nowUser() else {return}
                for exam in exams {
                    guard let name = exam["course"] as? String else { continue }
                    var examAttribute = exam
                    examAttribute.updateValue(year, forKey: "schoolYear")
                    examAttribute.updateValue(term, forKey: "schoolTerm")
                    if var result = Exam.fetch(by: NSPredicate(format: "course = %@", name)){
                        if result.isEmpty{
                            Exam.insert()?.update(of: examAttribute)?.beHold(of: user)
                        }else{
                            result.first?.update(of: examAttribute)
                            result.first?.beHold(of: user)
                            result.removeFirst()
                            result.forEach({$0.delete()})
                        }
                    }
                }
                successNotify()
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { failure in
            errorCallBack(-1 , "错误")
        }
    }
    
    /// 网络登出
    static func logout(type: Int = 1, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.logout(type: type)) { respon in
            guard let student = Student.nowUser() else { return }
            student.delete()
            HTTPCookieStorage.deleteAHUerCookie()
            successNotify()
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { failure in
            errorCallBack(-1 , "错误")
        }
    }
    
}
