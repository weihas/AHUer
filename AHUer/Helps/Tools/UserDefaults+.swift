//
//  UserDefaults+.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/10.
//

import Foundation

enum AHUerDefaultsKey: String {
    case AHUID
    case Username
    
    case BathRoom
    case LogginType
    
    case StartDate
    
    case Schedule_IsGridModel
    case Schedule_HideWeekend
    case Schedule_SelectedTerm
    case Schedule_ShowOtherWeek
    case Exam_SelectedTerm

    
    case Haptic_Error_Active
    case Haptic_Success_Active
}

extension AHUerDefaultsKey {
    static var removeDefaults: [AHUerDefaultsKey] {
        return [.AHUID, .Username, .Schedule_SelectedTerm]
    }
}
