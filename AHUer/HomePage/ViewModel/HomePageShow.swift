//
//  HomePageShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import Combine
import CoreData

class HomePageShow: ObservableObject{
    @Published private var model: HomePageInfo
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        model = HomePageInfo()
        self.context = context
    }
    
    // MARK: -Intent
    
    var nextCourse: Lecture{
        return model.nextCourse
    }
    
    var NorthBathroomisMen: Bool{
        return model.northBathroomisMen
    }
    
    var buttonsInfo: [ButtonInfo]{
        return model.buttonsInfo
    }
    
    var gpa: (Double,Double) {
        return model.gpa
    }
    
    func freshImmediatelyLecture() {
        model.fetchImmediatelyLecture(context: context)
        self.objectWillChange.send()
    }
    
    deinit {
        print("🌀HomePageShow released")
    }
}
