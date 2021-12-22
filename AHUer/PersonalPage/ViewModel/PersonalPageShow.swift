//
//  PersonalPageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation

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
    }
    
    var loggedUsers: [User]{
        return model.loggedUsers
    }
    
    
    // MARK: -Intents(s)
    
    func loggin(completion: @escaping (Bool)-> Void){
        guard let pw = password.rsaCrypto() else { return }
        let id = userID
        AhuerAPIProvider.loggin(userId: userID, password: pw, type: 1) { [weak self] in
            guard let self = self else {return}
            completion(true)
            guard let userName = Student.fetch(studentId: id)?.first?.studentName else { return }
            self.model.user = User(studentID: id, userName: userName, password: pw)
            AhuerAPIProvider.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm) {  } error: { _,_ in}
        } error: { [weak self] statusCode, message  in
            guard let self = self else { return }
            self.msg = message
            self.showAlert.toggle()
        }
        showLoggingPanel = false
    }
    
    
    func logout(){
        AhuerAPIProvider.logout(type: 1) { [weak self] in
            guard let self = self else {return}
            self.model.cleanUser()
        } error: { [weak self] statusCode, message in
            guard let self = self else {return}
            self.msg = message
            self.showAlert.toggle()
        }
    }
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
    
}
