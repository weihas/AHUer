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
    typealias successNotify = (_ status: Bool) -> Void
    /// 网络请求登录
    /// - Parameters:
    static func loggin(userId: String, password: String, type: Int, in context: NSManagedObjectContext, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack) {
        AhuerAPIProvider.netRequest(.login(userId: userId, password: password, type: type)) { [unowned context] respon in
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let data = respon?["data"] as? [String: Any]{
                let userName = data["name"] as? String
                //cookie存储
                HTTPCookieStorage.saveAHUerCookie()
                guard let result = Student.fetch(in: context, studentId: userId) else {return}
                if result.isEmpty{
                    Student.insert(in: context)?.update(in: context, of: ["studentID": userId, "studentName": userName])
                }else{
                    result.forEach {$0.update(in: context, of: ["studentID" : userId, "studentName" : userName])}
                }
                successNotify(true)
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { falilure in
            errorCallBack(-1 , "错误")
        }
    }
    
    /// 网络请求课表
    static func getSchedule(schoolYear: String, schoolTerm: Int, in context: NSManagedObjectContext, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.schedule(schoolYear: schoolYear, schoolTerm: schoolTerm)) { [unowned context] respon in
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let schedules = respon?["data"] as? [[String: Any]]{
                guard let user = Student.nowUser(context) else {return}
                do {
                    for schedule in schedules{
                        guard let scheduleId = schedule["courseId"] as? String, let result = Course.fetch(in: context, by: NSPredicate(format: "owner = %@ AND courseId = %@", user, scheduleId)) else {continue}
                        if result.isEmpty{
                            let course = Course.insert(in: context)?.update(in: context, of: schedule)
                            course?.owner = user
                            try context.save()
                        }else{
                            result.forEach({$0.update(in: context, of: schedule)})
                        }
                    }
                    successNotify(true)
                }catch{
                    successNotify(false)
                }
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { falilure in
            errorCallBack(-1 , "错误")
        }
    }
    
    ///网络请求成绩
    static func getScore(in context: NSManagedObjectContext, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.grade) { [unowned context] respon in
            if let grades = respon?["data"] as? [String: Any]{
                guard let user = Student.nowUser(context)?.update(in: context, of: grades) else {return}
                guard let termGradeLists = grades["termGradeList"] as? [[String:Any?]] else {return}
                do {
                    for term in termGradeLists{
                        guard let gpas = term["termGradeList"] as? [[String:Any]?], let schoolYear = term["schoolYear"] as? String, let schoolTerm = term["schoolTerm"] as? String else {continue}
                        
                        //清空原有的数据
                        Grade.fetch(context: context, schoolYear: schoolYear, schoolTerm: schoolTerm)?.forEach({$0.delete(in: context)})
                        let grade = Grade.insert(in: context)?.update(in: context, of: term)
                        for gpa in gpas{
                            let g = GPA.insert(in: context)?.update(in: context, of: gpa ?? [:])
                            g?.owner = grade
                            try context.save()
                        }
                        grade?.owner = user
                        try context.save()
                    }
                    successNotify(true)
                }catch{
                    successNotify(false)
                }
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { falilure in
            errorCallBack(-1 , "错误")
        }
    }
    
    /// 网络请求考场
    static func getExamination(year: String, term: Int, in context: NSManagedObjectContext, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.examInfo(schoolYear: year, schoolTerm: term)) { [unowned context] respon in
            if let exams = respon?["data"] as? [[String: Any]]{
                guard let user = Student.nowUser(context) else {return}
                do{
                    for exam in exams {
                        guard let name = exam["course"] as? String else { continue }
                        var examAttribute = exam
                        examAttribute.updateValue(year, forKey: "schoolYear")
                        examAttribute.updateValue(term, forKey: "schoolTerm")
                        if var result = Exam.fetch(in: context, by: NSPredicate(format: "course = %@", name)){
                            if result.isEmpty{
                                let tem = Exam.insert(in: context)?.update(in: context, of: examAttribute)
                                tem?.owner = user
                            }else{
                                result.first?.update(in: context, of: examAttribute)
                                result.first?.owner = user
                                result.removeFirst()
                                result.forEach({$0.delete(in: context)})
                            }
                            try context.save()
                        }
                    }
                    successNotify(true)
                }catch{
                    print("CoreData Save Error")
                    successNotify(false)
                }
            }
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { failure in
            errorCallBack(-1 , "错误")
        }
    }
    
    /// 网络登出
    static func logout(type: Int = 1, in context: NSManagedObjectContext, success successNotify: @escaping successNotify, error errorCallBack: @escaping errorCallBack){
        AhuerAPIProvider.netRequest(.logout(type: type)) { [unowned context] respon in
            guard let student = Student.nowUser(context) else { return }
            student.delete(in: context)
            HTTPCookieStorage.deleteAHUerCookie()
            successNotify(true)
        } error: { statusCode, message in
            errorCallBack(statusCode, message)
        } failure: { failure in
            errorCallBack(-1 , "错误")
        }
    }
    
}
