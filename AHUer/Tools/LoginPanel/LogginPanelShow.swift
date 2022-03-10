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
    @Published var isBachelor: Bool = false
    @Published var logginType: Int = 1
    
    
    //MARK: -Intents
    
    func loggin(){
        Task{
            do {
                guard let pw = password.rsaCrypto() else { throw AHUerAPIError(code: -10, title: "密码加密失败") }
                if (try await AHUerAPIProvider.loggin(userId: userID, password: pw, type: logginType) != nil) {
                    await freshAppStatus()
                }
            } catch {
                AlertView.showAlert(with: error)
            }
        }
    }

    func freshAppStatus() async {
        async let _ =  try? await AHUerAPIProvider.getSchedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)
        async let _ = try? await AHUerAPIProvider.getScore()
    }
    
    
}
