//
//  ScheduleShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

class ScheduleShow: ObservableObject {
    enum LearningTerm: Int, CaseIterable, Identifiable {
        var id: Int {
            return self.rawValue
        }
        
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        
        var schoolYear: String {
            let nowYear = 2018 + (self.rawValue/2)
            return "\(nowYear)" + "-" + "\(nowYear+1)"
        }
        
        var term: Int {
            return (self.rawValue)%2+1
        }
        
        var title: String {
            return schoolYear + " ~ " + "\(term)"
        }
    }
    
    
    @Published private var models: [ScheduleDay]
    @Published var selectedTerm: LearningTerm = .eight {
        didSet {
            withAnimation {
                freshScheduleInternet()
            }
        }
    }
    @Published var showTimeLine: Bool = false
    @Published var gridModel: Bool = false
    @Published var selectedDay: Weekday?
    
    init() {
        models = [ScheduleDay.timeLine] + Weekday.allCases.map({ScheduleDay(weekday: $0)})
    }
    
    //MARK: -Access to Model
    
    var hideWeekends: Bool {
        if models.count == 8 {
//            return !models[5].isModify && !models[6].isModify
            return false
        }
        return false
    }
    
    
    var weekdays: [ScheduleDay] {
        models.suffix(showTimeLine ? 8 : 7)
    }
    
    
    var galleryDay: ScheduleDay {
        guard let index = selectedDay?.rawValue else { return models.first ?? .timeLine }

        return models[index]
    }
    
    var items: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 20), spacing: 10, alignment: .top), count: showTimeLine ? 8 : 7  )
    }
    
    //MARK: -Intent(s)
    
    @MainActor
    func freshModel() {
        for index in models.indices {
            models[index].fetchModel()
        }
        reduce()
    }
    
    func addSchedule(){
#warning("添加课程表")
    }
    
    func cleanUp() {
        
    }
    
    
    @MainActor
    func changeSkimModel() {
        self.gridModel.toggle()
        if gridModel {
            reduce()
        } else {
            showTimeLine = false
        }
    }
    
    @MainActor
    func selectedDay(day: Weekday) {
        if !self.gridModel {
        self.selectedDay = day
        }
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
    
    deinit {
        print("🌀ScheduleShow released")
    }
}
