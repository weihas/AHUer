//
//  LogginPanelShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/10.
//

import Foundation
import SwiftUI


//登陆弹窗VM
class LogginPanelShow: ObservableObject {
    @Published var username: String = "E01814133"
    @Published var password: String = "Whw,0917"
    @Published var logginOrigin: Bool = false
    @AppStorage(AHUerDefaultsKey.AHUID.rawValue, store: .standard) var localID: String = ""
    @Published var saveCookie: Bool = true
    
    //MARK: -Access to Model
    
    var userNameIcon: String {
        guard !username.isEmpty else { return "person" }
        if username.isRegularForUserName {
            if username.count == 9 {
                return "person.fill.checkmark"
            }
            return "person.fill.questionmark"
        } else {
            return "person.fill.xmark"
        }
    }
    
    var passwordIcon: String {
        password.isEmpty ? "key" : "key.fill"
    }
    
    //MARK: -Intents
    
    func loggin() async -> Bool {
        do {
            guard let pw = try password.rsaCrypto() else { return false }
            
            try await AHUerAPIProvider.loggin(userId: username, password: pw, type: logginOrigin ? 2 : 1, saveCookie: saveCookie)
            await syncStatus()
            HapticManager.impactFeedBack(style: .success)
            await freshAppStatus()
            return true
        } catch {
            await AlertView.showAlert(with: error)
        }
        return false
    }
    
    @MainActor
    func syncStatus(){
        localID = username
    }

    func freshAppStatus() async {
        async let _ =  try? await AHUerAPIProvider.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)
        async let _ = try? await AHUerAPIProvider.getScore()
        async let _ = try? await AHUerAPIProvider.cardBalance()
        async let _ = try? await AHUerAPIProvider.bathroom()
    }
    
    
}
