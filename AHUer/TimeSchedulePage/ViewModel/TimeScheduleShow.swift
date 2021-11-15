//
//  TimeScheduleShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation
import CoreData

class TimeScheduleShow: ObservableObject{
    @Published var timetable: TimeSchedule
    
    init(){
        timetable = TimeSchedule()
    }
    
    // MARK: -Intent
    
    var timetableInfos: [ClassInOneDay]{
        return timetable.timeSchedule
    }
    
    var timeline: [String]{
        return ["8:20","9:15","10:20","11:15","14:00","14:55","15:50","16:45","19:00","19:55","20:50"]
    }
    
    func freshDataOfClass(context: NSManagedObjectContext, predicate: (String, String)){
        timetable.freshDataOfClass(context: context, predicate: predicate)
    }
    
    
    
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
