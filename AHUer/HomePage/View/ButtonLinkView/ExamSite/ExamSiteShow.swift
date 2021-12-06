//
//  ExamSiteShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation
import CoreData

class ExamSiteShow: ObservableObject {
    @Published var model: ExamSite
    
    init(){
        model = ExamSite()
    }
    
    //MARK: -Access to model
    
    var exams: [Exam]{
        return model.exams
    }
    
    
    //MARK: -Intents
    func getExamination(context: NSManagedObjectContext){
        AhuerAPIProvider.netRequest(.examInfo(schoolYear: "2020-2021", schoolTerm: 1)) { [unowned context] respon in
            if let exams = respon?["data"] as? [[String: Any]]{
                let user = Student.nowUser(context)
                for exam in exams {
                    do{
                        guard let name = exam["course"] as? String else { continue }
                        if var result = Exam.fetch(in: context, by: NSPredicate(format: "course = %@", name)){
                            if result.isEmpty{
                                let tem = Exam.insert(in: context)?.update(in: context, of: exam)
                                tem?.owner = user
                            }else{
                                result.first?.update(in: context, of: exam)
                                result.first?.owner = user
                                result.removeFirst()
                                result.forEach({$0.delete(in: context)})
                            }
                            try context.save()
                        }
                    }catch{
                        print("CoreData Svae Error")
                    }
                }
            }
        } error: { statusCode, message in
            print(message)
        } failure: { failure in
            print(failure)
        }

    }
    
    
}
