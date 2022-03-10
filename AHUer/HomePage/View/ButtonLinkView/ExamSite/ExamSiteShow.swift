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
    
    
    /// 刷新数据
    func freshScore() {
        Task{
            do {
                try await AHUerAPIProvider.getExamination(year: "2020-2021", term: 1)
                freshExamModelData()
            } catch {
                AlertView.showAlert(with: error)
            }
        }
    }
    
    
    
    /// 刷新本地数据
    func freshExamModelData(){
        model.freshExamData()
    }
    
    deinit {
        print("🌀ExamSiteShow released")
    }
}
