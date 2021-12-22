//
//  AHUAppInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation

/// AHUer全应用共享参数
class AHUAppInfo: ObservableObject {
    @Published var isLoggin: Bool = false{
        didSet {
            logged = isLoggin
        }
    }
    @Published var tabItemNum: Int = 0
    
    @SetStorage(key: "AHULoggin", default: false) private var logged: Bool
    
    init() {
        freshLogginStatus()
    }
    
    func freshLogginStatus(){
        self.isLoggin = logged
    }
    
    func cleanUp(){
        Student.cleanUp()
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}






