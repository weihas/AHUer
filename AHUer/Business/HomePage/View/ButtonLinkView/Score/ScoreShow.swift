//
//  ScoreShow.swift
//  AHUer
//
//  Created by admin on 2021/11/26.
//

import Foundation
import SwiftUI
import SwiftUICharts

class ScoreShow: ObservableObject {
    @Published private var model: ScoreGets
    @Published var showTerm: Int = 0
    
    init(){
        model = ScoreGets()
    }
    
    // MARK: -Access to the model
    
    var termNow: TermGrade? {
        if model.terms.indices.contains(showTerm){
            return model.terms[showTerm]
        } else {
            return nil
        }
    }
    
    var termList: [TermGrade] {
        return model.terms
    }
    
    var totalGpa: Double {
        return model.totalGradePointAverage
    }
    
    var totalCredit: Double {
        return model.totalCredit
    }
    
    var analyseData: ChartData {
        return ChartData(values: model.terms.map({($0.showTitle,$0.totalCredit)}))
    }
    
    
    func freshScoreData(){
        Task{
            do {
                try await AHUerAPIProvider.getScore()
                await freshlocal()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    // MARK: -Intents(s)
    
    @MainActor
    func freshlocal(){
        model.freshLocalGrade()
        showTerm = model.terms.last?.id ?? -1
    }
    
    deinit {
        print("🌀ScoreShow released")
    }
    
}
