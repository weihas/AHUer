//
//  TimeTable.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation
import CoreData
import SwiftUI

struct TimeSchedule {
    var timeSchedule: [ClassInOneDay]
    
    init(){
        timeSchedule = []
        for weekday in 1...7 {
            var schedule: [TableClassCellModel] = []
            for num in 1...6 {
                schedule.append(TableClassCellModel(id: num))
            }
            timeSchedule.append(ClassInOneDay(id: weekday, schedule: schedule))
        }
    }
    
    
    mutating func freshDataOfClass(context: NSManagedObjectContext, predicate: (String, String))  {
        guard let user = Student.fetch(context: context, predicate: predicate)?.first,
              let courses = (user.courses?.allObjects as? [Course]) else {return}
        
        let dic = courses.reduce([Int : [Course]]()) { partialResult, course in
            var history = partialResult
            let weekday = Int(course.weekday)
            history.updateValue([course] + (history[weekday] ?? []), forKey: weekday)
            return history
        }
        
        let color: [Color] = [.red,.blue,.green,.pink,.orange,.purple,.yellow]

        for (weekday, lectures) in dic {
            for course in lectures{
                let classColor = color.randomElement() ?? .blue
                timeSchedule[weekday-1].hasLecture = true
                timeSchedule[weekday-1].schedule[Int((course.startTime-1)/2)].changeInfo(name: course.name, location: course.location, lectureLengthIsTwo: course.length > 1, teacher: course.teacher, color: classColor)
                if course.length > 2{
                    timeSchedule[weekday-1].schedule[Int((course.startTime-1)/2)+1].changeInfo(name: course.name, location: course.location, lectureLengthIsTwo: course.length == 4, teacher: course.teacher, color: classColor)
                }
            }
        }
    }
}

struct ClassInOneDay: Identifiable{
    let id: Int
    var schedule: [TableClassCellModel]
    var hasLecture: Bool = false
    
    var weekDay: String{
        switch id {
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        default:
            return "日"
        }
    }
}

struct TableClassCellModel: Identifiable{
    var id: Int
    
    var name: String = ""
    var location: String = ""
    var isShow: Bool{get {name != ""} }
    var lectureLengthIsTwo: Bool = false
    var color: Color = .clear
    var teacher: String = ""
    
    mutating func changeInfo(name: String?, location: String?, lectureLengthIsTwo: Bool = true, teacher: String?, color: Color){
        self.name = name ?? ""
        self.location = location ?? ""
        self.lectureLengthIsTwo = lectureLengthIsTwo
        self.teacher = teacher ?? ""
        self.color = color
    }
    
}
