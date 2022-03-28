//
//  ScheduleTime.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import Foundation

enum ScheduleTime: Int, CaseIterable {
    case first = 0, second = 1, third, forth, fifth, sixth
}


extension ScheduleTime: Identifiable {
    
    var id: Int {
        return rawValue
    }
    
    var index: Int {
        return rawValue - 1
    }
    
    var timeLine: String {
        switch self {
        case .first:
            return "08:20"
        case .second:
            return "10:00"
        case .third:
            return "14:00"
        case .forth:
            return "15:40"
        case .fifth:
            return "19:00"
        case .sixth:
            return "20:40"
        }
    }
    
    var description: String {
        switch self {
        case .first:
            return "08:20"
        case .second:
            return "10:20"
        case .third:
            return "14:00"
        case .forth:
            return "15:40"
        case .fifth:
            return "19:00"
        case .sixth:
            return "20:40"
        }
    }
    
    var isMorning: Bool {
        return (1...2).contains(rawValue)
    }
    
    var isAfternoon: Bool {
        return (3...4).contains(rawValue)
    }
    
    var isNight: Bool {
        return rawValue == 5
    }
    
    var timeLineShowStyle: ScheduleStyle {
        switch self {
        case .sixth:
            return .one
        default:
            return .two
        }
    }
    
    func overTime(add length: Int) -> String {
        let result = Double(self.rawValue) + Double(length)/2
        if result == 1 {
            return "10:00"
        } else if result == 1.5 {
            return "11:05"
        } else if result == 2 {
            return "12:00"
        } else if result == 3 {
            return "15:40"
        } else if result == 3.5 {
            return "16:35"
        } else if result == 4 {
            return "17:30"
        } else if result == 5 {
            return "20:40"
        } else if result == 5.5 {
            return "21:35"
        } else {
            return "??:??"
        }
    }
    
}
