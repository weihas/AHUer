//
//  AHUAppInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI

/// AHUer全应用共享参数
class AHUAppInfo: ObservableObject {
    @AppStorage(AHUerDefaultsKey.AHUID.rawValue, store: .standard) var userID: String = ""
    ///当前的tableItemNum
    @Published var tabItemNum: Int = 0
    @Published var isLoggin: Bool = false
    
    init() {}
    
    func freshLogginStatus() {
        isLoggin = (userID != "")
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}






