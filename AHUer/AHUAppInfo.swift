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
    @Published var alertFlag: Bool = false
    var title = ""
    var message = ""
    
    init() {
        
    }
    
    func showAlert(title: String?, message: String?){
        guard let title = title, let message = message else { return }
        self.title = title
        self.message = message
        alertFlag.toggle()
    }
    
    func showAlert(with error: Error){
        guard let error = error as? AHUerAPIError else { return }
        self.title = error.title
        self.message = error.description
        alertFlag.toggle()
    }
    
    func cleanUp(){
        Student.cleanUp()
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}






