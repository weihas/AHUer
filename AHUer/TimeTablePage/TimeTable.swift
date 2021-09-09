//
//  TimeTable.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

struct TimeTable {
    var lectureOfWeekDay
}


struct Weekday {
    var day: Day
    var lectures: [Lecture]
    
    func getLectureVision(){
        if let lecturesOfToday = lectures.filter({$0.startTime})
    }
}

