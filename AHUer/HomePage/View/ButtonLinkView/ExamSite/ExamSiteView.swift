//
//  ExamSiteView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct ExamSiteView: View {
    @ObservedObject var vm: ExamSiteShow
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        VStack{
            Button("freshwithInternet"){
                vm.freshScoreModelByInternet(in: viewContext)
            }
            Button("freshLocal"){
                vm.freshExamModelData(in: viewContext)
            }
        }
        .navigationTitle("考试查询")
        .navigationBarTitleDisplayMode(.inline)
    }
}







//struct ExamSiteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExamSiteView()
//    }
//}
