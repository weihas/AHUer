//
//  ExamSite.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation

struct ExamSite{
    var exams: [Exam] = []
    
    mutating func freshExamData(){
        guard let user = Student.nowUser(),
              let result = Exam.fetch(by: NSPredicate(format: "owner = %@ AND schoolYear = %@ AND schoolTerm = %@", user, "2020-2021", NSNumber(value: 1)), sort: ["time": true] ) else { return }
        exams = result
    }
}
