//
//  ScoreGets.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation
import CoreData

struct ScoreGets {
    var list: [GradeList] = []
    
    
    
    init() {
    }
    
    mutating func freshList(context: NSManagedObjectContext){
        guard let user = Student.fetch(context: context, predicate: AHUAppInfo.whoAmIPredicate)?.first,
              let gradeScores = (user.grades?.allObjects as? [GradeScore]) else {return}
        self.list = gradeScores.map({GradeList($0)})
    }
}

struct GradeList: Identifiable {
    
    init(_ termList: GradeScore){
        self.id = termList.id
        self.schoolYear = termList.schoolYear ?? ""
        self.schoolTerm = termList.schoolTerm ?? ""
        self.termGradePoint = termList.termGardePoint
        self.termTotalCredit = termList.termTotalCredit
        self.termGradePointAverge = termList.termGradePointAverage
        
        if let gradeGpas = termList.gradeList?.allObjects as? [GPA]{
            self.Lectures = gradeGpas.map({LectureGPA($0)})
        }
    }
    
    
    let id: ObjectIdentifier
    
    /// 学年
    let schoolYear : String
    /// 学期
    let schoolTerm: String
    /// 学期学分绩点总和
    let termGradePoint: Double
    /// 学期中学分
    let termTotalCredit: Double
    /// 学期平均绩点
    let termGradePointAverge: Double
    
    var Lectures: [LectureGPA] = []
}


struct LectureGPA: Identifiable {
    
    init(_ gpa: GPA){
        self.id = gpa.id
        self.course = gpa.course ?? ""
        self.courseNum = gpa.courseNum ?? ""
        self.courseType = gpa.courseType ?? ""
        self.credit = gpa.credit
        self.gradePoint = gpa.gradePoint
        self.grade = gpa.grade
    }
    
    let id: ObjectIdentifier
    
    /// 课程名
    let course: String
    
    /// 课程号
    let courseNum: String
    
    /// 课程种类
    let courseType: String
    
    /// 课程学分
    let credit: Double
    
    /// 课程绩点
    let gradePoint: Double
    
    /// 课程成绩
    let grade: Double
}
