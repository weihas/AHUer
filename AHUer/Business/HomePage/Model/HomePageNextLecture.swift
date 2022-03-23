//
//  HomePageNextLecture.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/23.
//

import Foundation

struct HomePageNextLecture {
    
    private(set) var nextCourse: Course?
    private(set) var courseCount: Int = -1
    private(set) var myId: String?
    
    private(set) var progress: (value: Double, label: String)  = (0.3, " - / -")

    
    @MainActor
    mutating func fecthModel() {
        freshID()
        countCourseProgress()
        fetchImmediatelyLecture()
    }
    
    
    /// 刷新ID
    private mutating func freshID(){
        myId = Student.nowUser()?.studentID
    }
    
    /// 刷新即将开始的课
    private mutating func fetchImmediatelyLecture(){
        let today = Date()
        guard let user = Student.nowUser() else { nextCourse = nil; courseCount = 0; return }
        //        let predicete = NSPredicate(format: "owner = %@", user)
        let predicete = NSPredicate(format: "owner = %@ AND startWeek <= %@ AND endWeek >= %@ AND weekday = %@ AND startTime >= %@", user, NSNumber(value: today.studyWeek), NSNumber(value: today.studyWeek), NSNumber(value: today.weekDay), NSNumber(value: today.startTime ))
        guard let courses = Course.fetch(by: predicete, sort: ["startTime" : true])?.filter({$0.startTime + $0.length > Date().startTime}) else { nextCourse = nil; courseCount = 0 ; return }
        nextCourse = courses.first
        courseCount = courses.count
    }
    
    
    /// 计算剩余时间
    private mutating func countCourseProgress() {
        guard let nextCourse = nextCourse else { progress =  (0.3, " - / -"); return }
        
        let endWeek = Int(nextCourse.endWeek)
        let startWeek = Int(nextCourse.startWeek)
        let single = nextCourse.singleDouble
        
        let nowWeek = Date().studyWeek
        
        let length = (endWeek - startWeek + 1) / (single ? 2 : 1)
        
        let now = (nowWeek-startWeek+1) / (single ? 2 : 1)
        
        progress = (Double(now)/Double(length), "剩余次数: \(now) / \(length)")
    }
    
}
