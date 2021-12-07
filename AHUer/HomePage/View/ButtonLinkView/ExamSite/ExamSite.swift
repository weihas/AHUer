//
//  ExamSite.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation
import CoreData

struct ExamSite{
    var exams: [Exam] = []
    
    mutating func freshExamData(in context: NSManagedObjectContext){
        guard let user = Student.nowUser(context),
              let result = Exam.fetch(in: context, by: NSPredicate(format: "owner = %@ AND schoolYear = %@ AND schoolTerm = %@", user, "2020-2021", NSNumber(value: 1)), sort: ["time": true] ) else { return }
        do {
            exams = result.reduce([Exam]()) { partialResult, exam in
                if exam.owner == user{
                    return partialResult + [exam]
                }else{
                    exam.delete(in: context)
                    return partialResult
                }
            }
            try context.save()
        }catch{
            print("Core Data Save Error")
        }
    }
}
