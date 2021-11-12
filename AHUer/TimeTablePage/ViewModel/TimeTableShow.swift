//
//  TimeTableShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation
import CoreData

class TimeTableShow: ObservableObject{
    @Published var timetable: TimeTable
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        timetable = TimeTable()
        self.context = context
    }
    
    // MARK: -Intent
    
    var timetableInfos: [[TableClassCellModel]]{
        return timetable.tableClassCellModels
    }
    
    var timeline: [String]{
        return ["8:20","9:15","10:20","11:15","14:00","14:55","15:50","16:45","19:00","19:55","20:50"]
    }
    
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
