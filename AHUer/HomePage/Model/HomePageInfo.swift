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
    var nextCourse: Course?
    var northBathroomisMen: Bool
    var gpa: (thisGrade: Double , all: Double)
    
    var buttonsInfo: [ButtonInfo]
    
    init() {
        northBathroomisMen = true
        gpa = (5.0,4.0)
        buttonsInfo = ButtonInfo.buttonInfos
    }
    
    mutating func fetchImmediatelyLecture(context: NSManagedObjectContext){
        let today = Date()
        //TODO: -
        
        let predicete = NSPredicate(format: "weekday = %@", NSNumber(value: today.weekDay))
        
        
        guard let user = Student.nowUser(context),
              let courses = Course.fetch(in: context, by: predicete)?.filter({$0.owner == user}).sorted(by: {$0.startTime < $1.startTime}) else { nextCourse = nil ; return }
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
