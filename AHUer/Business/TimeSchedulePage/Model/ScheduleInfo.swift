//
//  ScheduleInfo.swift
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
    var length: Int = 2
    
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
    
    //中午和傍晚要padding
    var shouldPadding: Bool {
        return id == 2 || id == 4
    }
    
    func remove() {
        guard let courseID = courseID,
              let courses = Course.fetch(courseId: courseID) else { return }
        courses.forEach { course in
            course.delete()
        }
    }
}
