//
//  ExamSiteShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation

class ExamSiteShow: ObservableObject {
    @Published private var model: ExamSite
    
    init(){
        model = ExamSite()
    }
    
    //MARK: -Access to model
    
    var exams: [Exam]{
        return model.exams
    }
    
    
    //MARK: -Intents
    
    func freshScoreModelByInternet() async throws{
        try await AHUerAPIProvider.getExamination(year: "2020-2021", term: 1)
    }
    
    
    
    func freshExamModelData(){
        model.freshExamData()
    }
    
    deinit {
        print("🌀ExamSiteShow released")
    }
}
