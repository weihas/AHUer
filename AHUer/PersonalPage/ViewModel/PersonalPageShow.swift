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
    
    private let provider = AhuerAPIProvider.defaults
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.model = PersonalPageInfo()
        self.userID = ""
        self.password = ""
        self.context = context
    }
    
    func loggin(completion: @escaping (String, String)-> Void){
        provider.loggin(userId: userID, password: password) { [weak self] studentID, studentName  in
            guard let userName = studentName else { return }
            guard let result = Student.fetch(context: self?.context, predicate: ("studentID = %@", studentID)) else {return}
            if result.isEmpty{
                Student.insert(context: self?.context)?.update(context: self?.context, attributeInfo: ["studentID":studentID,"studentName":studentName])
            }else{
                result.forEach { student in
                    student.update(context: self?.context, attributeInfo: ["studentID":studentID,"studentName":studentName])
                }
            }
            completion(studentID,userName)
            self?.getschedule()
        }
    }
    
    func getschedule(){
        provider.getSchedule(schoolYear: "2020-2021", schoolTerm: "1") { [weak self] scheduledata in
            guard let schedules = scheduledata else {return}
            for schedule in schedules{
                guard let scheduleName = schedule["name"] as? String, let result = Course.fetch(context: self?.context, predicate: ("name = %@",scheduleName)) , let userID = self?.userID else { continue }
                if result.isEmpty{
                    let course = Course.insert(context: self?.context)?.update(context: self?.context, attributeInfo: schedule)
                    course?.owner = Student.fetch(context: self?.context, predicate: ("studentID = %@", userID))?[0]
                    try? self?.context.save()
                }else{
                    result[0].update(context: self?.context, attributeInfo: schedule)
                    result[0].owner = Student.fetch(context: self?.context, predicate: ("studentID = %@", userID))?[0]
                    try? self?.context.save()
                }
            }
        }
    }
    
    func logout(){
        let nowUserID = self.nowUser.studentID
        provider.logout { [weak self]success in
            guard let student = Student.fetch(context: self?.context, predicate: ("studentID = %@", nowUserID)) else { return }
            student.forEach({$0.delete(context: self?.context)})
        }
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
