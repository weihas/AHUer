//
//  CardBalanceShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/6.
//

import SwiftUI

class CardBalanceShow: ObservableObject {
    @Published var money: Double = 100.00
    @Published var transitionBalance: Double = 0.0
    
    //MARK: -Access to Model
    
    var moneyTitle: String {
        return String(format: "%.2f", money) + "¥"
    }
    
    var transitionBalanceTitle: String? {
        guard transitionBalance != 0 else { return nil }
            return String(format: "%.2f", transitionBalance) + "¥"
    }
    
    var userName: String {
        guard let userName = Student.nowUser()?.studentName else { return "AHUer" }
        var name = userName.transformToPinYin()
        let firstC = name.removeFirst()
        return firstC.uppercased() + name
    }
    

    
    //MARK: -Intent(s)
    
    @MainActor
    func freshwithInternet() async {
        do {
            let data = try await AHUerAPIProvider.asyncRequest(.campusCardBalance)
            let balance = data["data"]["balance"].doubleValue
            let transitionBalance = data["data"]["transitionBalance"].doubleValue
            self.money = balance
            self.transitionBalance = transitionBalance
            let user = Student.nowUser()
            user?.cardBalance = balance
            user?.toSaved()
        } catch {
            AlertView.showAlert(with: error)
        }
    }
    
    @MainActor
    func freshWithLoacl() {
        guard let money = Student.nowUser()?.cardBalance else { return }
        self.money = money
    }
}
