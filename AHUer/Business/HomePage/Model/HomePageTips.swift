//
//  HomePageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

struct HomePageTips {
    private(set) var gpa: (thisterm: Double , all: Double) = (0.0, 0.0)
    private(set) var exam: Exam?
    
    
    private mutating func fetchMyExam(){
        guard let user = Student.nowUser(),
              let nextExam = Exam.fetch(by: NSPredicate(format: "owner = %@ AND schoolYear = %@ AND schoolTerm = %@", user, "2020-2021", NSNumber(value: 1)), sort: ["time": true])?.first else { return }
        exam = nextExam
    }
    
    private mutating func fetchMyScore(){
        guard let user = Student.nowUser() else { gpa = (0.0, 0.0) ; return }
        gpa = (user.termGradePoint , user.totalGradePointAverage)
    }
    
    @MainActor
    mutating func fetchModel() {
        fetchMyExam()
        fetchMyScore()
    }

}
