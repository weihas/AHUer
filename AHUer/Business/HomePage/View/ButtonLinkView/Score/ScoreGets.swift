//
//  ScoreGets.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation

struct ScoreGets {
    
    /// 总学分绩点和
    private(set) var totalGradePoint: Double = 0
    
    /// 总学分
    private(set) var totalCredit: Double = 0
    
    /// 总绩点
    private(set) var totalGradePointAverage: Double = 0
    
    private(set) var grades: [Grade] = []
    
    init() { }
    
    
    /// 获取信息
    mutating func freshTotalPoint(){
        guard let user = Student.nowUser() else { return }
        self.totalGradePoint = user.totalGradePoint
        self.totalCredit = user.totalCredit
        self.totalGradePointAverage = user.totalCredit
        self.grades = Grade.fetch(by: NSPredicate(format: "owner = %@", user), sort: ["schoolYear": true])?.sorted(by: {$0.schoolYear ?? "" <= $1.schoolYear ?? "" && $0.schoolTerm ?? "" < $1.schoolTerm ?? ""}) ?? []
    }
}
