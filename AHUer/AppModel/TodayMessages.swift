//
//  TodayMessage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

struct TodayMessages {
    var lectures: [Course]
    var southBathroomisMen: Bool
    var gpa: (thisGrade: Double , all: Double)
    
    init() {
        lectures = []
        southBathroomisMen = false
        gpa = (5.00 , 5.00)
    }
    
}



