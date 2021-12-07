//
//  ScoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI
import SwiftUIChart

struct ScoreView: View {
    @ObservedObject var vm: ScoreShow
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        Button("Test") {
            vm.getScoreByInternet(in: viewContext)
        }
//        BarChartView(data: vm.gpaline, title: "Hello")
//        
//        LineChartView(data: vm.gpaLine, title: "GPA", rateValue: 1)
        
        
        
        ScrollView(.horizontal, showsIndicators: true) {

            HStack{
                Text("Placeholderajcbiabaicbabcaibaiubcaicbaciabcaibaicb")
                Text("Placeholderajcbiabaicbabcaibaiubcaicbaciabcaibaicb")
            }
            .navigationTitle("成绩查询")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            vm.freshmodel(context: viewContext)
        }
    }
}

//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView()
//    }
//}
