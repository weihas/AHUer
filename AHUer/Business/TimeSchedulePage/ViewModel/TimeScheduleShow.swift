//
//  TimeScheduleShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

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
    
    func freshScheduleInternet() {
        Task{
            do {
                try await AHUerAPIProvider.getSchedule(schoolYear: "2020-2021", schoolTerm: 1)
                await MainActor.run{
                    freshScheduleLocal()
                }
            } catch {
                AlertView.showAlert(with: error)
            }
        }
    }
    
    func freshScheduleLocal(){
        timetable.freshDataOfClass()
    }
    
    func cleanUp(){
        Student.cleanUp()
        freshScheduleLocal()
    }
    
    func addSchedule(){
        #warning("添加课程表")
    }
    
    
    deinit {
        print("🌀TimeTableShow released")
    }
    
}
