//
//  BathOpenShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/7.
//

import Foundation
import SwiftUI

class BathOpenShow: ObservableObject {
    @AppStorage(AHUerDefaultsKey.BathRoom.rawValue, store: .standard) private var northStatus: Bool = false
    @Published var northisMan: Bool = false
    
    init(){
    }
    
    func freshBathroom() {
        Task{
            do {
                let north = try await AHUerAPIProvider.asyncRequest(.bathroom).stringValue
                northStatus = (north == "m")
                await freshLocal()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    @MainActor
    func freshLocal() {
        northisMan = northStatus
    }
    
    deinit {
        print("🌀BathOpenShow released")
    }
}
