//
//  ScoreShow.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation
import CoreData

class ScoreShow: ObservableObject{
    private var model: ScoreGets
    
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
    
    
    // MARK: -Intents(s)
    func freshmodel(context: NSManagedObjectContext){
        model.freshTotalPoint(context: context)
    }
    
    ///网络请求成绩
    func getScore(context: NSManagedObjectContext){
        AhuerAPIProvider.netRequest(.grade) { [weak self, unowned context] respon in
            guard let self = self else { return }
            if let statusNum = respon?["success"] as? Bool, statusNum == true, var grade = respon?["data"] as? [String: Any]{
                let termGradeLists = grade.removeValue(forKey: "termGradeList")
                Student.nowUser(context)?.update(context: context, attributeInfo: grade)
                
                
                let b = grade
                let stop = 0
            }
        } error: { code,error  in
            print(error)
        } failure: { failure in
            print(failure)
        }
        
    }
    
    
}
