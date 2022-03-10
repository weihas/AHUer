//
//  ExamSiteView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct ExamSiteView: View {
    @ObservedObject var vm: ExamSiteShow
    
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
            .refreshable {
                vm.freshExamData()
            }
            .onAppear {
                vm.freshExamDataLocol()
            }
        }
        .toolbar {
            HStack{
                Button {
                    vm.freshExamData()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                
                Button {
                    //TODO: -
                    #warning("导入到系统日历")
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
