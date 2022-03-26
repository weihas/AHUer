//
//  ScheduleShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

class ScheduleShow: ObservableObject {
    @Published private var models: [ScheduleDay]
    @Published var showTimeLine: Bool = false
    
    init() {
        models = Weekday.allCases.map({ScheduleDay(weekday: $0)})
    }
    
    //MARK: -Access to Model
    
    var hideWeekends: Bool {
        if models.count == 7 {
//            return !models[5].isModify && !models[6].isModify
            return false
        }
        return false
    }
    
    
    var weekdays: [ScheduleDay] {
        var result = models
        if showTimeLine, result.count > 0 {
            result[0] = .timeLine
        }
        return result
    }
    
    
    var galleryDay: ScheduleDay {
        return models.first ?? .timeLine
    }
    
    var items: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 20), spacing: 10, alignment: .top), count: hideWeekends ? 5 : 7)
    }
    
    //MARK: -Intent(s)
    
    @MainActor
    func freshModel() {
        for index in models.indices {
            models[index].fetchModel()
        }
    }
    
    func addSchedule(){
#warning("添加课程表")
    }
    
    func cleanUp() {
        
    }
    
    func freshScheduleInternet() {
        Task{
            do {
                try await AHUerAPIProvider.getSchedule(schoolYear: "2020-2021", schoolTerm: 1)
                await freshModel()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    deinit {
        print("🌀ScheduleShow released")
    }
}
