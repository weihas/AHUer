//
//  ScoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var vm: ScoreShow
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        Button("Test") {
            vm.getScore(context: viewContext)
        }
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
