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
    
    func freshDataOfClass(context: NSManagedObjectContext, predicate: (String, String)){
        timetable.freshDataOfClass(context: context, predicate: predicate)
    }
    
    func freshDataWithInternet(context: NSManagedObjectContext, predicate: (String,String)){
        AhuerAPIProvider.netRequest(.schedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)) { [unowned context] respon in
            print(respon?["msg"] as? String ?? "")
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let schedules = respon?["data"] as? [[String: Any]]{
                for schedule in schedules{
                    guard let scheduleName = schedule["name"] as? String, let result = Course.fetch(context: context, predicate: ("name = %@",scheduleName)) else {continue}
                    if result.isEmpty{
                        let course = Course.insert(context: context)?.update(context: context, attributeInfo: schedule)
                        course?.owner = Student.fetch(context: context, predicate: predicate)?[0]
                        try? context.save()
                    }else{
                        result[0].update(context: context, attributeInfo: schedule)
                        result[0].owner = Student.fetch(context: context, predicate: predicate)?[0]
                        try? context.save()
                    }
                }
            }
        } error: { error in
            print(error)
        } failure: { failure in
            print(failure.localizedDescription)
        }
        timetable.freshDataOfClass(context: context, predicate: predicate)
    }
    
    
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
