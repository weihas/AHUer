//
//  ExamSiteView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct ExamSiteView: View {
    @ObservedObject var vm: ExamSiteShow
    @State var showYearChoose: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            termPicker
            List(vm.exams){ exam in
                examCard(exam: exam)
            }
            .refreshable {
                vm.freshExamData()
            }
            .onAppear {
                vm.freshExamDataLocol()
            }
        }
        .onTapGesture {
            withAnimation {
                showYearChoose = false
            }
        }
        .toolbar {
            toolBarContent
        }
        .navigationTitle("考试查询")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var termPicker: some View {
        VStack{
            Text(vm.selectedTerm.completeTitle)
                .padding(7)
                .background(RoundedRectangle(cornerRadius: 7).fill(colorScheme.isLight ? Color.lightGray : Color.darkGray))
                .foregroundColor(showYearChoose ? .blue : .primary)
                .onTapGesture{
                    withAnimation {
                        showYearChoose.toggle()
                    }
                }
            
            if showYearChoose {
                Picker(selection: $vm.selectedTerm) {
                    ForEach(vm.termtoShow) { term in
                        Text("\(term.completeTitle)")
                            .tag(term)
                    }
                } label: {
                    Label("选择", systemImage: "rectangle.on.rectangle")
                }
                .pickerStyle(.wheel)
            }
        }
    }
    
    
    var toolBarContent: some View {
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
    
    
    @ViewBuilder
    func examCard(exam: Exam) -> some View {
        VStack(alignment: .leading){
            Text(exam.course ?? "")
                .font(.system(size: 18, weight: .medium))
                .minimumScaleFactor(0.6)
                .lineLimit(1)
                .padding(.vertical, 8)
            Text(exam.time ?? "")
                .font(.callout)
                .underline()
                .padding(.bottom, 5)
            HStack{
                Text(exam.location ?? "")
                Spacer()
                Text("座位号: " + (exam.seatNum ?? "") )
            }
            .font(.body)

        }
    }
    
    
}






//struct ExamSiteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExamSiteView(vm: ExamSiteShow()) .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
