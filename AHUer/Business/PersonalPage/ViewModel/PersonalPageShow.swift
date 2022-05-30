//
//  PersonalPageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI
import MessageUI

class PersonalPageShow: ObservableObject {
    @AppStorage(AHUerDefaultsKey.AHUID.rawValue, store: .standard) private var userID: String = ""
    @Published var showLoggingPanel: Bool = false
    @Published var showLoggingChoose: Bool = false
    
    init(){}
    
    // MARK: -Access to the model
    
    
    func logginMessage(isLoggin: Bool) -> String {
        return isLoggin ? Student.nowUser()?.studentName ?? "---Error" : "登录"
    }
    
    var UserID: String {
        return userID
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
            await AHUerAPIProvider.logout(type: type)
            await cleanUp()
        }
    }
    
    @MainActor func cleanUp(){
        userID = ""
    }
    

    @MainActor func sendMail(){
        let str = String(format: "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external&jump_from=webapi", "948563698","0ac15317186f7778fc25f1cf10050b76e71b1134848e9924cbb1ef7f829d153b")
        guard let url = URL(string: str) else { return }
                UIApplication.shared.canOpenURL(url)
        UIApplication.shared.open(url)
//        if MFMailComposeViewController.canSendMail() {
//            let vc = MFMailComposeViewController()
//            vc.setSubject("Hello")
////            PresentView.show(vc: vc)
//            PresentView.show(vc: vc) {
//                print("A")
//            }
//        }
    }
    
    @MainActor func shareApp() {
        let url = URL(string: "https://github.com/weihas/AHUer")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        PresentView.show(vc: activityController)
    }
    
    
    
    deinit {
        print("🌀PersonalPageShow released")
    }
    
}
