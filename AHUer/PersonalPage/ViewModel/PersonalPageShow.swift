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
    
    typealias provider = AhuerAPIProvider
    
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
    
    func loggin(_ completion: @escaping completion){
        guard let pw = password.rsaCrypto() else { return }
        let id = userID
        AhuerAPIProvider.loggin(userId: userID, password: pw, type: 1) {[weak self] in
            guard let self = self, let userName = Student.fetch(studentId: id)?.first?.studentName else { return }
            self.model.freshData(userID: id, userPassWD: pw, userName: userName)
            AhuerAPIProvider.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm) { } errorCallback: { _ in }
            completion(true,nil,nil)
        } errorCallback: { error in
            completion(false, "登录失败", error.description)
        }
        showLoggingPanel = false
    }
    
    
    func logout(_ completion: @escaping completion){
        AhuerAPIProvider.logout(type:1) {[weak self] in
            guard let self = self else {return}
            self.model.cleanup()
            completion(true,nil,nil)
        } errorCallback: { error in
            completion(false,"登出失败", error.description)
        }
    }
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
    
}
