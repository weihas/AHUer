//
//  HomePageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

struct HomePageInfo {
    var nextCourse: Course?
    var northBathroomisMen: Bool
    var gpa: (thisGrade: Double , all: Double)
    
    init() {
        northBathroomisMen = true
        gpa = (5.0,4.0)
    }
    
    mutating func fetchImmediatelyLecture(){
        let today = Date()
        //TODO: -
        guard let user = Student.nowUser() else {nextCourse = nil; return}
        //        let predicete = NSPredicate(format: "owner = %@", user)
        let predicete = NSPredicate(format: "owner = %@ AND startWeek <= %@ AND endWeek >= %@ AND weekday = %@ AND startTime >= %@", user, NSNumber(value: today.studyWeek), NSNumber(value: today.studyWeek), NSNumber(value: today.weekDay), NSNumber(value: today.startTime ))
        guard let courses = Course.fetch(by: predicete, sort: ["startTime" : true]) else { nextCourse = nil ; return }
        nextCourse = courses.first
    }
}
