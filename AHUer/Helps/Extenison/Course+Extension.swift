//
//  Course+Extension.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import Foundation

extension Course {
    
    var startTimeInt: Int {
        Int(self.startTime)
    }
    
    var weekDay: Weekday? {
        return Weekday(rawValue: Int(weekday))
    }
    
    var lectureTime: ScheduleTime? {
        return ScheduleTime(rawValue: Int(startTime))
    }
}
