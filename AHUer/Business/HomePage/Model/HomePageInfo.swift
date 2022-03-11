//
//  HomePageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

struct HomePageInfo {
    var northBathroomisMen: Bool
    var gpa: (thisterm: Double , all: Double)
    var exam: (name: String, time: String)?
    
    init() {
        northBathroomisMen = true
        gpa = (0.0, 0.0)
        exam = nil
    }
    
    mutating func fetchMyExam(){
        guard let user = Student.nowUser(),
              let nextExam = Exam.fetch(by: NSPredicate(format: "owner = %@ AND schoolYear = %@ AND schoolTerm = %@", user, "2020-2021", NSNumber(value: 1)), sort: ["time": true])?.first,
              let name = nextExam.course,
              let time = nextExam.time else {
                  exam = nil
                  return
              }
        
        exam = (name,time)
    }
    
    mutating func fetchMyScore(){
        guard let user = Student.nowUser() else { gpa = (0.0, 0.0) ; return }
        gpa = (user.termGradePoint , user.totalGradePointAverage)
    }
}
