//
//  ScoreShow.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation
import CoreData
import SwiftUIChart

class ScoreShow: ObservableObject{
    @Published private var model: ScoreGets
    
    init(){
        model = ScoreGets()
    }
    
    // MARK: -Access to the model
    
    /// 总学分绩点和
    var totalGradePoint: Double{
        return model.totalGradePoint
    }
   
    /// 总学分
    var totalCredit: Double {
        return model.totalCredit
    }
    
    /// 总绩点
    var totalGradePointAverage: Double{
        return model.totalGradePointAverage
    }
    
    var grades: [Grade]{
        return model.grades
    }
    
    var gpaLine: [Double]{
        return model.grades.map({$0.termGradePointAverage})
    }
    
    var gpaline: ChartData {
        return ChartData(values: model.grades.map({(($0.schoolYear ?? "") + "\n" + ($0.schoolTerm ?? "") ,$0.termTotalCredit)}))
    }
    
    
    
    // MARK: -Intents(s)
    func freshmodel(context: NSManagedObjectContext){
        model.freshTotalPoint(context: context)
    }
    
    ///网络请求成绩
    func getScore(context: NSManagedObjectContext){
        AhuerAPIProvider.netRequest(.grade) { [unowned context] respon in
            if let grades = respon?["data"] as? [String: Any]{
                let user = Student.nowUser(context)?.update(in: context, of: grades)
                guard let termGradeLists = grades["termGradeList"] as? [[String:Any?]] else {return}
                do {
                    for term in termGradeLists{
                        guard let gpas = term["termGradeList"] as? [[String:Any]?], let schoolYear = term["schoolYear"] as? String, let schoolTerm = term["schoolTerm"] as? String else {continue}
                        
                        //清空原有的数据
                        Grade.fetch(context: context, schoolYear: schoolYear, schoolTerm: schoolTerm)?.forEach({$0.delete(in: context)})
                        
                        let grade = Grade.insert(in: context)?.update(in: context, of: term)
                        for gpa in gpas{
                            let g = GPA.insert(in: context)?.update(in: context, of: gpa ?? [:])
                            g?.owner = grade
                            try context.save()
                        }
                        grade?.owner = user
                        try context.save()
                    }
                }catch{
                    print("CoreData Save Error")
                }

            }
        } error: { code,error  in
            print(error)
        } failure: { failure in
            print(failure)
        }
        
    }
    
    
}
