//
//  StartTime.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/7.
//

import Foundation

enum StartTime: Int, CaseIterable{
    case one = 1
    case three = 3
    case five = 5
    case seven = 7
    case nine = 9
}
extension StartTime: Identifiable {
    
    var timeSegemnt: String{
        switch self {
        case .one:
            return "8:20 - 10:00"
        case .three:
            return "10:20 - 12:00"
        case .five:
            return "14:00 - 15:40"
        case .seven:
            return "15:50 - 17:30"
        case .nine:
            return "19:00 - 21:30"
        }
    }
    
    var description: String {
        switch self {
        case .one:
            return "8:20"
        case .three:
            return "10:20"
        case .five:
            return "14:00"
        case .seven:
            return "15:50"
        case .nine:
            return "19:00"
        }
    }
    
    var id: Int {
        rawValue
    }
}

