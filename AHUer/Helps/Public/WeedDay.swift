//
//  WeedDay.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import Foundation

enum Weekday: Int, CaseIterable {
    case Mon = 1
    case Tue = 2
    case Wed
    case Thur
    case Fri
    case Sat
    case Sun
    

}

extension Weekday: Identifiable {
    var id: Int {
        return self.rawValue
    }
    
    var date: Date {
        let today = Date()
        let weekday = today.weekDay
        let delta = (self.rawValue - weekday)
        guard let day = today.adding(day: delta) else  {
            fatalError("Unresolved error")
        }
        return day
    }
    
    var description: String{
        switch self {
        case .Mon:
            return "一"
        case .Tue:
            return "二"
        case .Wed:
            return "三"
        case .Thur:
            return "四"
        case .Fri:
            return "五"
        case .Sat:
            return "六"
        case .Sun:
            return "日"
        }
    }
    
    var completeDescription: String {
        return "周" + description
    }
}
