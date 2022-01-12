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
    
    func freshScoreModelByInternet(_ completion: @escaping completion) {
        AhuerAPIProvider.getExamination(year: "2020-2021", term: 1) {
            self.freshExamModelData()
        } errorCallback: { error in
            completion(false, "获取考场信息失败", error.description)
        }

    }
    
    
    
    func freshExamModelData(){
        model.freshExamData()
    }
}
