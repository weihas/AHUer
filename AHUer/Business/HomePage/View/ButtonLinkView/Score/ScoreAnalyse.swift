//
//  ScoreAnalyse.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/13.
//

import SwiftUI

struct ScoreAnalyse: View {
    @ObservedObject var vm: ScoreShow
    var body: some View {
        NavigationView{
            VStack{
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
