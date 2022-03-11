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
    @AppStorage(AHUerDefaultsKey.AHUID.rawValue, store: .standard) private var userID: String = ""
    @Published var showLoggingPanel: Bool = false
    @Published var showLoggingChoose: Bool = false
    
    init(){}
    
    // MARK: -Access to the model
    
    
    func logginMessage(isLoggin: Bool) -> String {
        return isLoggin ? Student.nowUser()?.studentName ?? "---Error" : "登录"
    }
    
    
    // MARK: -Intents(s)
    
    func logginButtonTap(isLoggin: Bool){
        if isLoggin {
            showLoggingChoose.toggle()
        } else {
            showLoggingPanel.toggle()
        }
    }
    
    
    func logout(type: Int) {
        Task{
            do {
                try await AHUerAPIProvider.logout(type: type)
                await cleanUp()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    @MainActor func cleanUp(){
        userID = ""
    }
    

    @MainActor func sendMail(){
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.setSubject("Hello")
            PresentView.show(vc: vc)
        }
    }
    
    @MainActor func shareApp() {
        let url = URL(string: "https://github.com")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        PresentView.show(vc: activityController)
    }
    
    
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
}
