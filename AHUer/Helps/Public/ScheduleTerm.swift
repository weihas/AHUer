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
    
    var schoolYear: String {
        let nowYear = 2018 + (self.rawValue/2)
        return "\(nowYear)" + "-" + "\(nowYear+1)"
    }
    
    var term: Int {
        return (self.rawValue)%2+1
    }
    
    var title: String {
        return schoolYear + " ~ " + "\(term)"
    }
}
