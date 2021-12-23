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
    @AppStorage("AHULoggin", store: .standard) var isLoggin: Bool = false
    @Published var tabItemNum: Int = 0
    
    
    
    init() {
        
    }
    
    func cleanUp(){
        Student.cleanUp()
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}






