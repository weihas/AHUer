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
    @Published var userID: String = "E01814133"
    @Published var password: String = "Whw,0917"
    @Published var logginType: Bool = false
    @AppStorage(AHUerDefaultsKey.AHUID.rawValue, store: .standard) var localID: String = ""
    
    
    //MARK: -Intents
    
    func loggin() async -> Bool {
        do {
            guard let pw = try password.rsaCrypto() else { return false }
            
            try await AHUerAPIProvider.loggin(userId: userID, password: pw, type: logginType ? 2 : 1)
            await syncStatus()
            await freshAppStatus()
            
            return true
        } catch {
            await AlertView.showAlert(with: error)
        }
        return false
    }
    
    @MainActor
    func syncStatus(){
        localID = userID
    }

    func freshAppStatus() async {
        async let _ =  try? await AHUerAPIProvider.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)
        async let _ = try? await AHUerAPIProvider.getScore()
        async let _ = try? await AHUerAPIProvider.cardBalance()
    }
    
    
}
