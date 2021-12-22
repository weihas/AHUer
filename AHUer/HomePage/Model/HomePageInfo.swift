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
    
    var buttonsInfo: [ButtonInfo]
    
    init() {
        northBathroomisMen = true
        gpa = (5.0,4.0)
        buttonsInfo = ButtonInfo.buttonInfos
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
