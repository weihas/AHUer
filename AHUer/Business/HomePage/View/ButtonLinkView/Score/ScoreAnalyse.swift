//
//  ScoreAnalyse.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/13.
//

import SwiftUI
import SwiftUICharts

struct ScoreAnalyse: View {
    @ObservedObject var vm: ScoreShow
    var body: some View {
        NavigationView{
            ScrollView{
                BarChartView(data: vm.analyseData, title: "学期学分获取", legend: "学期")
                    .aspectRatio(1.2, contentMode: .fit)
                LineChartView(data: vm.gpaData, maxValue: 5.0, minvalue: 0)
                    .aspectRatio(1.8, contentMode: .fit)
                    .padding()
                Text("总绩点: \(vm.totalGpa)")
                Text("总学分: \(vm.totalCredit)")
            }
            .navigationTitle("成绩分析")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ScoreAnalyse_Previews: PreviewProvider {
    static var previews: some View {
        ScoreAnalyse(vm: ScoreShow())
    }
}
