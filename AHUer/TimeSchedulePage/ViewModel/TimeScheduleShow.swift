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
        return ["8:20","10:20","14:00","15:50","19:00","20:50"]
    }
    
    func freshDataOfClass(context: NSManagedObjectContext){
        timetable.freshDataOfClass(context: context)
        self.objectWillChange.send()
    }
    
    func freshDataByInternet(context: NSManagedObjectContext){
        AhuerAPIProvider.getSchedule(schoolYear: "2020-2021", schoolTerm: 1, in: context) { [weak self, unowned context] status in
            guard let self = self else { return }
            self.freshDataOfClass(context: context)
//            self.objectWillChange.send()
        } error: { statusCode, message in
            
        }

    }
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
