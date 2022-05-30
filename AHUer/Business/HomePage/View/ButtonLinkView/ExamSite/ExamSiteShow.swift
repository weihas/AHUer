//
//  ExamSiteShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/6.
//

import Foundation
import SwiftUI

class ExamSiteShow: ObservableObject {
    @Published private var model: [Exam]
    @AppStorage(AHUerDefaultsKey.Exam_SelectedTerm.rawValue, store: .standard) var selectedTerm: LearningTerm = .eight {
        didSet {
            withAnimation {
                freshExamData()
            }
        }
    }
    init(){
        model = []
    }
    
    //MARK: -Access to model
    
    var exams: [Exam]{
        return model
    }
    
    var termPickerTitle: String {
        return selectedTerm.title
    }
    
    var termtoShow: [LearningTerm] {
        let startYear: Int = Int(Student.nowUser()?.startYear ?? Int64(Date().year))
        return LearningTerm.showTerms(of: startYear)
    }
    
    
    //MARK: -Intents
    
    
    /// 刷新数据
    func freshExamData() {
        let schoolYear = selectedTerm.schoolYear
        let schoolTerm = selectedTerm.term
        Task{
            do {
                try await AHUerAPIProvider.getExamination(year: schoolYear, term: schoolTerm)
                await freshExamDataLocol()
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    /// 刷新本地数据
    @MainActor
    func freshExamDataLocol(){
        let schoolYear = selectedTerm.schoolYear
        let schoolTerm = selectedTerm.term
        guard let user = Student.nowUser(),
              let result = Exam.fetch(by: NSPredicate(format: "owner = %@ AND schoolYear = %@ AND schoolTerm = %@", user, schoolYear, NSNumber(value: schoolTerm)), sort: ["time": true]) else { return }
        model = result
    }
    
    deinit {
        print("🌀ExamSiteShow released")
    }
}
