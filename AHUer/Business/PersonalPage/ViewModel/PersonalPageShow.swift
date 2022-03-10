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
    
    func showLogginPanel(){
        
    }
    
    func logout(type: Int){
        Task{
            do {
                try await AHUerAPIProvider.logout(type: type)
                self.model.cleanup()
            } catch {
                AlertView.showAlert(with: error)
            }
        }
    }
    
    func freshData(_ userID: String, _ password: String, _ userName: String){
        self.model.freshData(userID: userID, userPassWD: password, userName: userName)
    }

    func sendMail(){
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.setSubject("Hello")
            PresentView.show(vc: vc)
        }
    }
    
    func shareApp() {
        let url = URL(string: "https://github.com")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        PresentView.show(vc: activityController)
    }
    
    
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
}
