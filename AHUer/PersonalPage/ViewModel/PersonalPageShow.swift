//
//  PersonalPageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import CoreData

class PersonalPageShow: ObservableObject {
    @Published private var model: PersonalPageInfo
    @Published var userID: String
    @Published var password: String
    @Published var showAlert: Bool = false
    @Published var showLoggingPanel: Bool = false
    var msg: String?
    
    typealias provider = AhuerAPIProvider
   
    
    init(context: NSManagedObjectContext){
        self.model = PersonalPageInfo()
        self.userID = ""
        self.password = ""
    }
    
    func loggin(context: NSManagedObjectContext, completion: @escaping (Bool)-> Void){
        guard let pw = password.rsaCrypto() else {return}
        let studentID = userID
        provider.netRequest(.login(userId: userID, password: pw, type: 1)) { [weak self, unowned context] respon in
            self?.msg = respon?["msg"] as? String
            if let status = respon?["success"] as? Bool, let data = respon?["data"] as? [String: Any], let userName = data["name"] as? String{
                
                if let cookie = HTTPCookieStorage.shared.cookies(for: URL(string: "https://ahuer.cn/api")!)?.first{
                    UserDefaults.standard.setValue(cookie.name + "=" + cookie.value, forKey: "AHUCookie")
                }
                    
                guard let userId = self?.userID else {return}
                self?.model.user = User(studentID: userId, userName: userName)
                if status{
                    UserDefaults.standard.setValue(pw, forKey: "AHUPassword")
                    self?.model.user = User(studentID: studentID, userName: userName)
                    completion(true)
                    guard let result = Student.fetch(context: context, predicate: NSPredicate(format: "studentID = %@", studentID) ) else {return}
                    if result.isEmpty{
                        Student.insert(context: context)?.update(context: context, attributeInfo: ["studentID":studentID,"studentName":userName])
                    }else{
                        result.forEach { student in
                            student.update(context: context, attributeInfo: ["studentID":studentID,"studentName":userName])
                        }
                    }
                }
                self?.getschedule(context: context)
            }else{
                self?.showAlert.toggle()
            }
        } error: { code, error in
            print(error)
        } failure: { failure in
            print(failure)
        }
        showLoggingPanel = false
    }
    
    func getschedule(context: NSManagedObjectContext){
        provider.netRequest(.schedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)) { [weak self, unowned context] respon in
            print(respon?["msg"] as? String ?? "")
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let schedules = respon?["data"] as? [[String: Any]]{
                for schedule in schedules{
                    guard let scheduleName = schedule["name"] as? String, let result = Course.fetch(context: context, predicate: NSPredicate(format: "name = %@", scheduleName)) else {continue}
                    if result.isEmpty{
                        let course = Course.insert(context: context)?.update(context: context, attributeInfo: schedule)
                        course?.owner = Student.nowUser(context)
                        try? context.save()
                    }else{
                        result[0].update(context: context, attributeInfo: schedule)
                        result[0].owner = Student.nowUser(context)
                        try? context.save()
                    }
                }
            }else{
                self?.showAlert.toggle()
            }
        } error: { code, error in
            print(error)
        } failure: { failure in
            print(failure)
        }
    }
    
    func logout(context: NSManagedObjectContext){
        let nowUserID = self.nowUser.studentID
        provider.netRequest(.logout(type: 1)) { [weak context] respon in
            guard let student = Student.fetch(context: context, predicate: NSPredicate(format: "studentID = %@", nowUserID)) else { return }
            student.forEach({$0.delete(context: context)})
        } error: { code, error  in
            print(error)
        } failure: { failure in
            print(failure)
        }
        UserDefaults.standard.removeObject(forKey: "AHUCookie")
    }
    
    var nowUser: User{
        get {
            return model.user
        }
        set {
            model.user = newValue
        }
    }
    
    var loggedUsers: [User]{
        return model.loggedUsers
    }
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
    
}
