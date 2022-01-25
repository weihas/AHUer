//
//  PersonalPageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation

typealias completion =  (_ status: Bool, _ title: String?, _ description: String?) -> Void

class PersonalPageShow: ObservableObject {
    @Published private var model: PersonalPageInfo
    @Published var userID: String = ""
    @Published var password: String = ""
    @Published var showLoggingPanel: Bool = false
    
    
    init(){
        model = PersonalPageInfo()
    }
    
    // MARK: -Access to the model
    
    var nowUser: PersonalPageInfo{
        get { model }
    }
    
//    var loggedUsers: [User]{
//        return model.loggedUsers
//    }
    
    
    // MARK: -Intents(s)
    
    func loggin() async throws -> Bool {
        guard let pw = password.rsaCrypto() else { return false }
        let id = userID
        self.showLoggingPanel.toggle()
        if try await AHUerAPIInteractor.loggin(userId: userID, password: pw, type: 1) {
            guard let userName = Student.fetch(studentId: id)?.first?.studentName else {return false}
            self.model.freshData(userID: id, userPassWD: pw, userName: userName)
            try await AHUerAPIInteractor.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)
        }
        return true
    }
    
    
    func logout(type: Int) async throws{
        try await AHUerAPIInteractor.logout(type: type)
        self.model.cleanup()
    }
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
    
}
