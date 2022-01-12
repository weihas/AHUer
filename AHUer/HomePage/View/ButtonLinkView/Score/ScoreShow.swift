//
//  ScoreShow.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation
import UIKit
import SwiftUI
//import SwiftUIChart

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
    
//    var gpaline: ChartData {
//        return ChartData(values: model.grades.map({(($0.schoolYear ?? "") + "\n" + ($0.schoolTerm ?? "") ,$0.termTotalCredit)}))
//    }
    
    func getScoreByInternet(_ completion: @escaping completion){
        AhuerAPIProvider.getScore {
            
        } errorCallback: { error in
            completion(false, "成绩查询失败", error.description)
        }
    }
    
    
    // MARK: -Intents(s)
    func freshmodel(){
        model.freshTotalPoint()
    }
    
}
