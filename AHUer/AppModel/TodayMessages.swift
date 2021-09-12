//
//  TodayMessage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

struct TodayMessages {
    var lectures: [Lecture]
    var southBathroomisMen: Bool
    var gpa: (thisGrade: Double , all: Double)
    
    init() {
        lectures = [Lecture(id: UUID(), name: "高等数学", location: "博北A103", startTime: Date(timeIntervalSinceNow: 2000), endTime: Date(timeIntervalSinceNow: 3000))]
        southBathroomisMen = false
        gpa = (5.00 , 5.00)
    }
    
}



