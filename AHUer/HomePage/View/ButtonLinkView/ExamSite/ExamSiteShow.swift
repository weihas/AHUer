//
//  ExamSiteShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation
import CoreData

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
    
    func freshScoreModelByInternet(in context: NSManagedObjectContext) {
        AhuerAPIProvider.getExamination(year: "2020-2021", term: 1, in: context) { [weak self, unowned context] in
            guard let self = self else {return}
            self.freshExamModelData(in: context)
        } error: { statusCode, message in
        }

    }
    
    
    
    func freshExamModelData(in context: NSManagedObjectContext){
        model.freshExamData(in: context)
    }
}
