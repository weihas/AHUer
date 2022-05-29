//
//  ScheduleTerm.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/7.
//

import Foundation

enum LearningTerm: Int, CaseIterable, Identifiable {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    
    var id: Int {
        return self.rawValue
    }
    
    static var showTerms: [LearningTerm] {
        let startYear: Int = Int(Student.nowUser()?.startYear ?? Int64(Date().year))
        let nowYear: Int = Date().year
        var delta = (nowYear - startYear)*2
        delta = delta == 0 ? 1 : delta
        return Array(LearningTerm.allCases.prefix(delta))
    }
    
    var schoolYear: String {
        let startYear: Int = Int(Student.nowUser()?.startYear ?? Int64(Date().year))
        let nowYear = startYear + (self.rawValue/2)
        return "\(nowYear)" + "-" + "\(nowYear+1)"
    }
    
    var term: Int {
        return (self.rawValue)%2+1
    }
    
    var title: String {
        return schoolYear + " ~ " + "\(term)"
    }
}
