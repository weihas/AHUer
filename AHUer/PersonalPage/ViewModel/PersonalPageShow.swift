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
    @Published var userID: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var showLoggingPanel: Bool = false
    
    var msg: String?
    
    typealias provider = AhuerAPIProvider
    
    init(){
        model = PersonalPageInfo()
    }
    
    // MARK: -Access to the model
    
    var nowUser: User{
        get { model.user }
        set { model.user = newValue}
    }
    
    var loggedUsers: [User]{
        return model.loggedUsers
    }
    
    
    // MARK: -Intents(s)
    
    func loggin(context: NSManagedObjectContext, completion: @escaping (Bool)-> Void){
        guard let pw = password.rsaCrypto() else { return }
        provider.netRequest(.login(userId: userID, password: pw, type: 1)) { [weak self, unowned context] respon in
            guard let self = self else {return}
            if let data = respon?["data"] as? [String: Any], let userName = data["name"] as? String{
                //cookie存储
                HTTPCookieStorage.saveAHUerCookie()
                
                self.model.user = User(studentID: self.userID, userName: userName, password: pw)
                
                completion(true)
                
                guard let result = Student.fetch(in: context, studentId: self.userID) else {return}
                
                if result.isEmpty{
                    Student.insert(in: context)?.update(in: context, of: ["studentID":self.userID,"studentName":userName])
                }else{
                    result.forEach {$0.update(in: context, of: ["studentID" : self.userID, "studentName" : userName])}
                }
                
                // TODO: -GetSchedule
                self.getschedule(context: context)
                
            }
        } error: { [weak self] code, msg in
            self?.msg = msg
            self?.showAlert.toggle()
            print(msg)
        } failure: { failure in
            print(failure)
        }
        showLoggingPanel = false
    }
    
    func getschedule(context: NSManagedObjectContext){
        provider.netRequest(.schedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)) { [unowned context] respon in
            if let schedules = respon?["data"] as? [[String: Any]]{
                for schedule in schedules{
                    guard let scheduleName = schedule["name"] as? String, let result = Course.fetch(in: context, courseName: scheduleName) else {continue}
                    do{
                        if result.isEmpty{
                            let course = Course.insert(in: context)?.update(in: context, of: schedule)
                            course?.owner = Student.nowUser(context)
                            try context.save()
                        }else{
                            result[0].update(in: context, of: schedule)
                            result[0].owner = Student.nowUser(context)
                            try context.save()
                        }
                    }catch{
                        NSLog("CoreData Save Error")
                    }
                }
            }
        } error: { [weak self] code, msg in
            self?.msg = msg
            self?.showAlert.toggle()
            print(msg)
        } failure: { failure in
            print(failure)
        }
    }
    
    func logout(context: NSManagedObjectContext){
        provider.netRequest(.logout(type: 1)) { [unowned context] respon in
            guard let student = Student.nowUser(context) else { return }
            student.delete(in: context)
        } error: {  [weak self] code, msg in
            self?.msg = msg
            self?.showAlert.toggle()
            print(msg)
        } failure: { failure in
            print(failure)
        }
        UserDefaults.standard.removeObject(forKey: "AHUCookie")
    }
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
    
}

extension HTTPCookieStorage{
    static func saveAHUerCookie(){
        if let cookie = HTTPCookieStorage.shared.cookies(for: URL(string: "https://ahuer.cn/api")!)?.first{
            UserDefaults.standard.setValue(cookie.name + "=" + cookie.value, forKey: "AHUCookie")
        }
    }
}
