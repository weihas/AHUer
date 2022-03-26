//
//  ScheduleCourseInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/26.
//

import Foundation
import SwiftUI

struct ScheduleInfo: Identifiable {
    var id: Int
    var name: String?
    var teacher: String?
    var location: String?
    var courseID: String?
    
    var isTimeLine: Bool = false
    
    var style: ScheduleStyle
    
    var color: Color {
        if teacher == nil {
            return .clear
        } else {
            guard let courseID = courseID else { return .clear }
            return Color.courseColor(courseId: courseID)
        }
    }
    
    var geometryID: UUID = UUID()
    
    var time: ScheduleTime {
        return ScheduleTime(rawValue: id) ?? .sixth
    }
        
    var shouldPadding: Bool {
        return id == 2 || id == 4
    }
    
}
