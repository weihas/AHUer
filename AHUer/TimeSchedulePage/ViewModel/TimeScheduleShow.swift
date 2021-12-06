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
    }
    
    func freshDataWithInternet(context: NSManagedObjectContext){
        AhuerAPIProvider.netRequest(.schedule(schoolYear: Date().studyYear, schoolTerm: Date().studyTerm)) { [unowned context] respon in
            print(respon?["msg"] as? String ?? "")
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let schedules = respon?["data"] as? [[String: Any]]{
                for schedule in schedules{
                    guard let scheduleName = schedule["name"] as? String, let result = Course.fetch(in: context, by: NSPredicate(format: "name = %@", scheduleName)) else {continue}
                    if result.isEmpty{
                        let course = Course.insert(in: context)?.update(in: context, of: schedule)
                        course?.owner = Student.nowUser(context)
                        try? context.save()
                    }else{
                        result[0].update(in: context, of: schedule)
                        result[0].owner = Student.nowUser(context)
                        try? context.save()
                    }
                }
            }
        } error: { code, error in
            print(error)
        } failure: { failure in
            print(failure.localizedDescription)
        }
        timetable.freshDataOfClass(context: context)
    }
    
    
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
