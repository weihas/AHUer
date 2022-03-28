//
//  ScheduleStyle.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/26.
//

import Foundation

/// Grid 模式下的Style
enum ScheduleStyle: Equatable {
    case hide
    case spacer(length: Int)
    case one
    case two
    case three
    case four
    
    static func getStyle(length: Int64) -> Self {
        if length == 1 {
            return .one
        } else if length == 2 {
            return .two
        } else if length == 3 {
            return .three
        } else if length == 4 {
            return .four
        } else {
            return .spacer(length: 2)
        }
    }
    
    var rawValue: Int {
        switch self {
        case .hide:
            return -1
        case .spacer:
            return 0
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        }
    }
    
    var aspectRatio: Double {
        switch self {
        case .hide:
            return 0.5
        case .spacer(let length):
            return 1.0/Double(length)
        case .one:
            return 1.0
        case .two:
            return 0.5
        case .three:
            return 1.0/3.0
        case .four:
            return 0.25
        }
    }
}
