//
//  ScoreCardView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/12/26.
//

import Foundation
import SwiftUI

struct GradeCard: View{
    var grade: Grade
    
    var gpas: [GPA]{
        let predicate = NSPredicate(format: "owner = %@", grade)
        guard let results = GPA.fetch(by: predicate, in: PersistenceController.shared.container.viewContext) else {return []}
        return results
    }
    
    var body: some View {
        VStack{
            Text(grade.term ?? "")
            Text("\(grade.termGradePointAverage)")
            List(gpas){ gpa in
                HStack{
                    Text(gpa.course ?? "")
                    Spacer()
                    Text("\(gpa.gradePoint)")
                }
            }
        }
    }
}
