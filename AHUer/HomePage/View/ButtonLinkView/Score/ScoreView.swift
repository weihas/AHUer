//
//  ScoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var vm: ScoreShow
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: true) {
                 
            }
            .onAppear {
                vm.freshmodel()
            }
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

//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView()
//    }
//}
