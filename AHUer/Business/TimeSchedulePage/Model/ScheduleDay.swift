//
//  ScheduleDay.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import Foundation
import SwiftUI

struct ScheduleDay {
    let weekday: Weekday?
    
    var courses: [ScheduleInfo] = []
    
    var isModify: Bool = false
    
    mutating func cleanData() {
        courses = ScheduleTime.allCases.map({ScheduleInfo(id: $0.id, style: .spacer(length: 2))})
        courses[courses.endIndex-1] = ScheduleInfo(id: courses.endIndex-1, style: .spacer(length: 1))
        isModify = false
    }
    
    
    /// 刷新model
    /// - Parameter weekNum: 第几周
    mutating func fetchModel(with weekNum: Int) {
       //如果weekday为空，说明是timeline，不要刷新
        guard let weekday = weekday else { return }
        //刷新当天
        cleanData()
        

        
        guard let user = Student.nowUser() else { return }
        let predicate = NSPredicate(format: "owner = %@ AND startWeek <= %@ AND endWeek >= %@ AND weekday = %@", user, NSNumber(value: weekNum), NSNumber(value: weekNum), NSNumber(value: weekday.rawValue))
        guard let courses = Course.fetch(by: predicate, sort: ["startTime": true])?.filter({!$0.singleDouble || (Int($0.startWeek) + weekNum)%2 == 0 }), !courses.isEmpty else { return }
        
        self.isModify = true
        
        for course in courses {
            let courseIndex = (course.startTimeInt-1)/2
            if self.courses.indices.contains(courseIndex) {
                self.courses[courseIndex] = ScheduleInfo(id: courseIndex, name: course.name, teacher: course.teacher, location: course.location, courseID: course.courseId, length: Int(course.length) ,style: .getStyle(length: course.length) )
            }
        }
        pack()
    }
    
    mutating func pack() {
        for (index,course) in courses.enumerated() {
            switch course.style {
            case .three:
                if index == 0 || index == 2 {
                    if courses[index+1].style == .spacer(length: 2){
                        courses[index+1].style = .spacer(length: 1)
                    }
                } else if index == 4{
                    if courses[index+1].style == .spacer(length: 1){
                        courses[index+1].style = .hide
                    }
                }
            case .four:
                if index == 0 || index == 2 {
                    if courses[index+1].style == .spacer(length: 2){
                        courses[index+1].style = .hide
                    }
                }
            default:
                break
            }
        }
    }
}


extension ScheduleDay: Identifiable {
    var id: Int {
        return weekday?.rawValue ?? -1
    }
    
    func dateOffSetWeekNum(weekNumDelta: Int) -> Date {
        return weekday?.date.adding(week: weekNumDelta) ?? .now
    }
    
    var isTimeLine: Bool {
        guard let firstCourse = self.courses.first else { return false }
        return self.weekday == nil && firstCourse.isTimeLine
    }
    //一天之中有效的课
    var solidCourse: [ScheduleInfo] {
        return self.courses.filter({$0.teacher != nil})
    }
    
    static var timeLine: ScheduleDay {
        ScheduleDay(weekday: nil,
                    courses: ScheduleTime.allCases.map({ScheduleInfo(id: $0.id, isTimeLine: true, style: $0.timeLineShowStyle)})
        )
    }
}


