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
        timetable.freshDataOfClass()
        self.objectWillChange.send()
    }
    
    func freshDataByInternet(_ completion: @escaping callback) {
        AhuerAPIProvider.getSchedule(schoolYear: "2020-2021", schoolTerm: 1) {[weak self] in
            guard let self = self else { return }
            self.freshDataOfClass()
        } errorCallback: { error in
            completion(false, "课表获取失败" ,error.description)
        }
    }
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
