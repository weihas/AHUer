//
//  ScoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: ScoreShow
    @State var showTimeChoose: Bool = false
    @State var showAnalyse: Bool = false
    
    var body: some View {
        VStack{
            scorePicker
            bodyList
        }
        .onAppear {
            vm.freshlocal()
        }
        .toolbar {
            toolBarContext
        }
        .popover(isPresented: $showAnalyse) {
            ScoreAnalyse(vm: vm)
        }
        .navigationTitle("成绩查询")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var toolBarContext: some View {
        HStack{
            Button {
                showAnalyse.toggle()
                showTimeChoose = false
            } label: {
                Label("分析", systemImage: "chart.pie")
            }
            Button {
                vm.freshScoreData()
                showTimeChoose = false
            } label: {
                Label("刷新", systemImage: "arrow.clockwise")
            }
        }
    }
    
    var scorePicker: some View {
        VStack{
            Text(vm.termNow?.showTitle ?? " 刷新数据以获取成绩 ")
                .padding(7)
                .background(RoundedRectangle(cornerRadius: 7).fill(Color(red: 0.93, green: 0.93, blue: 0.93)))
                .foregroundColor(showTimeChoose ? .blue : .black)
                .onTapGesture{
                    withAnimation {
                        if vm.termNow == nil {
                            vm.freshScoreData()
                        } else {
                            showTimeChoose.toggle()
                        }
                    }
                }
            
            if showTimeChoose {
                Picker(selection: $vm.showTerm) {
                    ForEach(vm.termList) { term in
                        Text("\(term.showTitle)")
                            .tag(term.id)
                    }
                } label: {
                    Label("选择", systemImage: "rectangle.on.rectangle")
                }
                .pickerStyle(.wheel)
            }
        }
        
    }
    
    
    var bodyList: some View {
        Group{
            if let term = vm.termNow {
                Form {
                    Section {
                        ForEach(term.grades) { grade in
                            HStack{
                                Text(grade.course ?? "")
                                Spacer()
                                Text("\(grade.gradePoint, specifier: "%.2f")")
                            }
                        }
                    } header: {
                        VStack(alignment: .leading) {
                            Text("平均绩点: \(term.GPA, specifier: "%.2f")")
                            Text("学期总学分: \(term.totalCredit, specifier: "%.1f")")
                        }
                    }
                }
            } else {
                Spacer()
            }
        }
        .onTapGesture {
            withAnimation {
                showTimeChoose = false
            }
        }
    }
    
    
//    var superList: some View {
//        ZStack{
//            ForEach(vm.termList.reversed()) { term in
//                let scale = 10.0*Double(term.id)
//                List(term.grades) { grade in
//                    HStack{
//                        Text(grade.course ?? "")
//                        Spacer()
//                        Text("\(grade.gradePoint, specifier: "%.2f")")
//                    }
//                }
//                .scaleEffect(0.9, anchor: UnitPoint.topLeading)
//                .offset(x: scale, y: scale)
//                .zIndex(-Double(term.id))
//            }
//        }
//    }
    
}





//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView(vm: ScoreShow())
//    }
//}
