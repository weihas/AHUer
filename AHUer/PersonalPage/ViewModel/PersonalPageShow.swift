//
//  PersonalPageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI
import MessageUI

typealias completion =  (_ status: Bool, _ title: String?, _ description: String?) -> Void

class PersonalPageShow: ObservableObject {
    @Published private var model: PersonalPageInfo
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
    
    func loggin(userID: String, password: String, type: Int) async throws -> Bool {
        guard let pw = password.rsaCrypto() else { return false }
        self.showLoggingPanel.toggle()
        print(Thread.current)
        
        if let userName = try await AHUerAPIProvider.loggin(userId: userID, password: pw, type: 1) {
            self.freshData(userID, pw, userName)
            
            try? await AHUerAPIProvider.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)
            return true
        }
        return false
    }
    
    
    func logout(type: Int) async throws{
        try await AHUerAPIProvider.logout(type: type)
        self.model.cleanup()
    }
    
    func freshData(_ userID: String, _ password: String, _ userName: String){
        self.model.freshData(userID: userID, userPassWD: password, userName: userName)
    }
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
    func sendMail(){
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.setSubject("Hello")
            UIApplication.shared.windows.first?.rootViewController!.present(vc, animated: true, completion: nil)
        }
    }
    
    func shareApp() {
        let url = URL(string: "https://github.com")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
    
}
