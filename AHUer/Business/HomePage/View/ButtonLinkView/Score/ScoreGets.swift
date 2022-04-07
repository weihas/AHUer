//
//  ScoreGets.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation

struct ScoreGets {
    var terms: [TermGrade] = []
    
    /// 总学分绩点和
    private(set) var totalGradePoint: Double = 0
    
    /// 总学分
    private(set) var totalCredit: Double = 0
    
    /// 总绩点
    private(set) var totalGradePointAverage: Double = 0
    
    
    init() { }
    
    
    
    //获取本地的数据
    @MainActor
    mutating func freshLocalGrade() {
        guard let user = Student.nowUser() else { return }
        totalGradePoint = user.totalGradePoint
        totalCredit = user.totalCredit
        totalGradePointAverage = user.totalGradePointAverage
        
        let predicate = NSPredicate(format: "owner = %@", user)
        let dic = Grade.fetch(by: predicate, sort: ["schoolYear": true])?.reduce(into: [String: [Grade]](), { partialResult, grade in
            guard let year = grade.schoolYear, let term = grade.schoolTerm else { return }
            let key = year + "|" + term
            partialResult.updateValue((partialResult[key] ?? []) + [grade], forKey: key)
        }).sorted(by: {$0.key < $1.key}) ?? []
        
        terms = dic.indices.map({ TermGrade(id: $0, grades: dic[$0].value) })
        
    }
    
    struct TermGrade: Identifiable {
        let id: Int
        
        var grades: [Grade] = []
        
        //学期总学分
        var totalCredit: Double
        
        //学期平均绩点
        var GPA: Double
        
        var showTitle: String {
            guard let year = grades.first?.schoolYear, let term = grades.first?.schoolTerm else { return " -- " }
            return year + " 第" + term + "学期"
        }
        
        init(id: Int, grades: [Grade]) {
            self.id = id
            self.grades = grades
            self.GPA = grades.map({$0.gradePoint}).reduce(0.0, +) / Double(grades.count)
            self.totalCredit = grades.map({$0.credit}).reduce(0.0, +)
        }
    }
}
