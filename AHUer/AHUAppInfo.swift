//
//  AHUAppInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import CoreData

/// AHUer全应用共享参数
class AHUAppInfo: ObservableObject {
    @Published var isLoggin: Bool = false
    @Published var tabItemNum: Int = 0
    
    @SetStorage(key: "AHULoggin", default: false) private var logged: Bool
    
    init() {
        freshLogginStatus()
    }
    
    func freshLogginStatus(){
        self.isLoggin = logged
    }
    
    func cleanUp(context: NSManagedObjectContext){
        Student.fetch(in: context, by: nil)?.forEach({ student in
            student.delete(in: context)
        })
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}






