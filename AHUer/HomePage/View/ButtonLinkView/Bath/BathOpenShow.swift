//
//  BathOpenShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/7.
//

import Foundation

class BathOpenShow: ObservableObject {
    @Published var northisMan: Bool = false
    
    init(){
    }
    
    func getBathInfo() async throws {
        let north = try await AHUerAPIProvider.asyncRequest(.bathroom).stringValue
        await MainActor.run {
            northisMan = (north == "m")
        }
    }
    
    deinit {
        print("🌀BathOpenShow released")
    }
}
