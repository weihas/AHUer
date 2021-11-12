//
//  HomePageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI
import CoreData

struct HomePageInfo {
    var nextCourse: Lecture
    var northBathroomisMen: Bool
    var gpa: (thisGrade: Double , all: Double)
    
    var buttonsInfo: [ButtonInfo]
    
    init() {
        nextCourse = Lecture()
        northBathroomisMen = true
        gpa = (5.0,4.0)
        buttonsInfo = ButtonInfo.buttonInfos
    }
    
    mutating func fetchImmediatelyLecture(context: NSManagedObjectContext){
        nextCourse = Lecture()
        guard let user = Student.fetch(context: context, predicate: ("studentID = %@","E01814133"))?.first,
              let courses = (user.courses?.allObjects as? [Course])?.sorted(by: {$0.startTime < $1.startTime}) else {return}

        for course in courses {
            if Date().weekDay == course.weekday, course.startTime > 0{
                nextCourse.time = "\(course.startTime)"
                nextCourse.name = "\(course.name ?? "")"
                nextCourse.location = course.location ?? ""
                break
            }
        }
    }
}

struct Lecture {
    var name: String = " --"
    var location: String = "--"
    var time: String = "--"
}

struct ButtonInfo: Identifiable{
    static let buttonInfos: [ButtonInfo] =  [ButtonInfo(id: 0, name: "空闲教室", icon: "building.columns.fill", color: Color.green),
                                             ButtonInfo(id: 1, name: "成绩查询", icon: "doc.text.below.ecg.fill", color: Color.orange),
                                             ButtonInfo(id: 2, name: "考场查询", icon: "signpost.right.fill", color: Color.red),
                                             ButtonInfo(id: 3, name: "浴室开放", icon: "drop.fill", color: Color.purple),
                                             ButtonInfo(id: 4, name: "更多功能", icon: "hand.point.up.braille.fill", color: Color.pink)]
    let id: Int
    let name: String
    let icon: String
    let color: Color
}
