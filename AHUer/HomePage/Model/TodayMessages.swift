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
        lectures = []
        southBathroomisMen = false
        gpa = (5.0 , 5.0)
    }
    
}

struct Lecture: Hashable ,Equatable{
    let id: UUID
    var name: String
    var location: String
    var startTime: Data
    var endTime: Data
}

