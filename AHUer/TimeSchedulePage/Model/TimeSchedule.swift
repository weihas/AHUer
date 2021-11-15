//
//  TimeTable.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation
import CoreData

struct TimeSchedule {
    var timeSchedule: [ClassInOneDay]
    
    init(){
        timeSchedule = []
        for weekday in 1...7 {
            var schedule: [TableClassCellModel] = []
            for num in 1...11 {
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
        
        for (weekday, lectures) in dic {
            for course in lectures{
                timeSchedule[weekday-1].schedule[Int(course.startTime-1)].changeInfo(name: course.name, location: course.location, lectureLengthIsTwo: course.singleDouble)
            }
        }
    }
}

struct ClassInOneDay: Identifiable{
    let id: Int
    var schedule: [TableClassCellModel]
    
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
    
    mutating func changeInfo(name: String?, location: String?, lectureLengthIsTwo: Bool = true){
        self.name = name ?? ""
        self.location = location ?? ""
        self.lectureLengthIsTwo = lectureLengthIsTwo
    }
    
}

struct classData {
    var weekday = "周几"
    var startWeek = "开始的周"
    var endWeek =  "结束的周"
    var extra =  "附加信息默认为空"
    var location = "上课地点"
    var name = "课程名称"
    var teacher =  "老师姓名"
    var length =  "课程长度（几节课）"
    var startTime =  "开始时间（第几节开始）"
    var singleDouble =  "是否单双周。0为否，1为是"
    var courseId =  "课程代码"
}
