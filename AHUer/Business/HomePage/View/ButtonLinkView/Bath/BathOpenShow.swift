//
//  BathOpenShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/7.
//

import Foundation
import SwiftUI

class BathOpenShow: ObservableObject {
    @AppStorage(AHUerDefaultsKey.BathRoom.rawValue, store: .standard)  var northisMen: Bool = false
    
    func freshBathroom() {
        Task{
            do {
                let north = try await AHUerAPIProvider.asyncRequest(.bathroom).stringValue
                await updateState(state: north == "m")
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    @MainActor
    func freshModel() {
    }
    
    @MainActor
    private func updateState(state: Bool) {
        northisMen = state
        guard let user = Student.nowUser() else { return }
    }
    
    deinit {
        print("🌀BathOpenShow released")
    }
}
