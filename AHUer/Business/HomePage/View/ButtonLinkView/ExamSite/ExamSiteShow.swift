//
//  ExamSiteShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation

class ExamSiteShow: ObservableObject {
    @Published private var model: [Exam]
    
    init(){
        model = []
    }
    
    //MARK: -Access to model
    
    var exams: [Exam]{
        return model
    }
    
    
    //MARK: -Intents
    
    
    /// 刷新数据
    func freshExamData() {
        Task{
            do {
                try await AHUerAPIProvider.getExamination(year: "2020-2021", term: 1)
                await freshExamDataLocol()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    /// 刷新本地数据
    @MainActor
    func freshExamDataLocol(){
        guard let user = Student.nowUser(),
              let result = Exam.fetch(by: NSPredicate(format: "owner = %@ AND schoolYear = %@ AND schoolTerm = %@", user, "2020-2021", NSNumber(value: 1)), sort: ["time": true], in: PersistenceController.shared.container.viewContext ) else { return }
        model = result
    }
    
    deinit {
        print("🌀ExamSiteShow released")
    }
}
