//
//  ScoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var vm: ScoreShow
    @State var showDetail: Bool = false
    var body: some View {
        VStack{
            if showDetail{
                GradeLine()
                    .frame(width: 400, height: 600)
                    .transition(.scale)
            }
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack{
                    ForEach(vm.grades) { grade in
                        GradeCard(grade: grade)
                            .frame(minWidth: 320, minHeight: 500)
                            .onTapGesture {
                                withAnimation {
                                    showDetail.toggle()
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            vm.freshmodel()
        }
        .toolbar {
            Button {
                vm.getScoreByInternet()
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        }
        .navigationTitle("成绩查询")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

struct GradeLine: View {
    var body: some View {
        VStack{
            //Line
            Text("这里是线的分布")
        }
    }
}

//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView(vm: ScoreShow())
//    }
//}
