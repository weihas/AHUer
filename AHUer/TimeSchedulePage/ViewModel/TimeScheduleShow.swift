//
//  TimeScheduleShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

class TimeScheduleShow: ObservableObject{
    @Published var timetable: TimeSchedule
    
    typealias callback =  (_ status: Bool, _ title: String?, _ description: String?) -> Void
    
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
    
    func freshDataOfClass(){
        print("read")
        timetable.freshDataOfClass()
        self.objectWillChange.send()
    }
    
    func freshDataByInternet() async throws{
        try await AHUerAPIProvider.getSchedule(schoolYear: "2020-2021", schoolTerm: 1)
    }
    
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
