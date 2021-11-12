//
//  AHUAppInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import CoreData
class AHUAppInfo: ObservableObject {
    @Published var isLoggin: Bool = false
    @Published var tabItemNum: Int = 0
    
    @SetStorage(key: "AHULoggin", default: false) var logged: Bool
    
    var context: NSManagedObjectContext
    
    lazy var homePageVM = HomePageShow(context: context)
    lazy var timeTableVM = TimeTableShow(context: context)
    lazy var personPageVM = PersonalPageShow(context: context)
    
    
    init(context: NSManagedObjectContext) {
        self.context = context
        freshLogginStatus()
    }
    
    func freshLogginStatus(){
        self.isLoggin = logged
    }
    
    func cleanUp(){
        Student.fetch(context: context, predicate: nil)?.forEach({ student in
            student.delete(context: context)
        })
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}






