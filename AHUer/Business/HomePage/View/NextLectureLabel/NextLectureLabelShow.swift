//
//  NextLectureLabelShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/11.
//

import SwiftUI

class NextLectureLabelShow: ObservableObject{
    @Published var nextCourse: Course?
    @Published var courseCount: Int = -1
    var myId: String?
    
    init(){
        freshUser()
    }
    
     // MARK: -Access to the model
    
    var nextCouseName: String {
        return nextCourse?.name ?? "暂无课程"
    }
    
    var nextCourseProcess: (label: String, value: Double) {
        guard let nextCourse = nextCourse else {
            return (" - / -", 0.3)
        }
        
        let endWeek = Int(nextCourse.endWeek)
        let startWeek = Int(nextCourse.startWeek)
        let single = nextCourse.singleDouble
        
        let nowWeek = Date().studyWeek
        
        let length = (endWeek - startWeek + 1) / (single ? 2 : 1)
        
        let now = (nowWeek-startWeek+1) / (single ? 2 : 1)
        
        
        return ("剩余次数: \(now) / \(length)", Double(now)/Double(length))
    }
    
    var startTime: String {
        StartTime(rawValue: Int(nextCourse?.startTime ?? 0))?.des ?? " Time "
    }
    
    var teacherName: String {
        nextCourse?.teacher ?? " Teacher "
    }
    
    var location: String {
        nextCourse?.location ?? " Location "
    }
    
    var welcomeTitle: String {
        guard let id = myId else { return "请登录" }
        return "\(id)👋"
    }
    
    var welcomeSubtitle: String? {
        guard myId != nil else { return nil }
        if courseCount < 1 {
            return "你今天没有课"
        }
        return "你今天还有\(courseCount)节课"
    }
    
    
    func freshUser(){
        myId = Student.nowUser()?.studentID
    }
    
    
     // MARK: -Intents(s)
    
    
    
    func fetchImmediatelyLecture(){
        let today = Date()
        guard let user = Student.nowUser() else { nextCourse = nil; courseCount = 0; return }
        //        let predicete = NSPredicate(format: "owner = %@", user)
        let predicete = NSPredicate(format: "owner = %@ AND startWeek <= %@ AND endWeek >= %@ AND weekday = %@ AND startTime >= %@", user, NSNumber(value: today.studyWeek), NSNumber(value: today.studyWeek), NSNumber(value: today.weekDay), NSNumber(value: today.startTime ))
        guard let courses = Course.fetch(by: predicete, sort: ["startTime" : true]) else { nextCourse = nil; courseCount = 0 ; return }
        nextCourse = courses.first
        courseCount = courses.count
    }
}
