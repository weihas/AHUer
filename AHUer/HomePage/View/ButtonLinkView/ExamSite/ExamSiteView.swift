//
//  ExamSiteView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct ExamSiteView: View {
    @ObservedObject var vm: ExamSiteShow
    @State var point: Double = 0
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        VStack{
            List(vm.exams){ exam in
                VStack(alignment: .leading){
                    Text(exam.time ?? "")
                        .font(.callout)
                    Text(exam.course ?? "")
                        .font(.headline)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                    HStack{
                        Text(exam.location ?? "")
                        Spacer()
                        Text("座位号: " + (exam.seatNum ?? "") )
                    }
                    .font(.subheadline)
                }
            }
            .onAppear {
                vm.freshExamModelData(in: viewContext)
            }
        }
        .toolbar {
            HStack{
                Button {
                    vm.freshScoreModelByInternet(in: viewContext)
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
                Button {
                    //TODO: -
                    print("导入到系统日历")
                } label: {
                    Image(systemName: "calendar.badge.plus")
                }
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
