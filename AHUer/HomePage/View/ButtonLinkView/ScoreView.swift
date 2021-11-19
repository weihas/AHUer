//
//  ScoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import SwiftUI

struct ScoreView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack{
                Text("Placeholderajcbiabaicbabcaibaiubcaicbaciabcaibaicb")
                Text("Placeholderajcbiabaicbabcaibaiubcaicbaciabcaibaicb")
            }
            .navigationTitle("成绩查询")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
