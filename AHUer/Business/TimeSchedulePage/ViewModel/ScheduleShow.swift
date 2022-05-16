//
//  ScheduleShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

class ScheduleShow: ObservableObject {
    // [Time Mon Tue Wed Thr Fri Sta Sun]
    @Published private var models: [ScheduleDay]
    @Published var selectedTerm: LearningTerm = .eight {
        didSet {
            withAnimation {
                freshScheduleInternet()
            }
        }
    }
    @Published var showTimeLine: Bool = false
    @AppStorage(AHUerDefaultsKey.Schedule_IsGridModel.rawValue, store: .standard) var gridModel:  Bool = false
    @AppStorage(AHUerDefaultsKey.Schedule_HideWeekend.rawValue, store: .standard) var hideWeekend:  Bool = false
    @Published var selectedDay: Weekday?
    @Published var showEditView: Bool = false
    @Published var editLecture: ScheduleInfo?
    
    init() {
        models = [ScheduleDay.timeLine] + Weekday.allCases.map({ScheduleDay(weekday: $0)})
    }
    
    //MARK: -Access to Model
    
    
    var weekdays: [ScheduleDay] {
        var result = models
        
        //如果不展示时间表。去掉第一个
        if !showTimeLine {
            result.removeFirst()
        }
        //如果隐藏周末
        if hideWeekend {
            result.removeLast(2)
        }
        return result
    }
    
    
    var galleryDay: ScheduleDay {
        guard let index = selectedDay?.rawValue else { return models.first ?? .timeLine }

        return models[index]
    }
    
    var items: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 20), spacing: 10, alignment: .top), count: weekdays.count)
    }
    
    //MARK: -Intent(s)
    
    @MainActor
    func freshModel() {
        for index in models.indices {
            models[index].fetchModel()
        }
        reduce()
    }
    
    @MainActor
    func addSchedule(){
        self.showEditView.toggle()
    }
    
    @MainActor
    func cleanUp() {
        guard let user = Student.nowUser() else { return }
        user.courses = nil
        user.toSaved()
        freshModel()
    }
    
    @MainActor
    func changeSkimModel() {
        gridModel.toggle()
        if gridModel {
            reduce()
        } else {
            showTimeLine = false
        }
    }
    
    @MainActor
    func selectedDay(day: Weekday) {
        self.selectedDay = day
    }
    
    
    @MainActor
    func reduce() {
        self.selectedDay = Weekday(rawValue: Date().weekDay)
    }
    
    func freshScheduleInternet() {
        Task{
            do {
                try await AHUerAPIProvider.getSchedule(schoolYear: selectedTerm.schoolYear, schoolTerm: selectedTerm.term)
                await freshModel()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    @MainActor
    func openEditView(with scheduleInfo: ScheduleInfo) {
        self.editLecture = scheduleInfo
        self.showEditView.toggle()
    }
    
    deinit {
        print("🌀ScheduleShow released")
    }
}
