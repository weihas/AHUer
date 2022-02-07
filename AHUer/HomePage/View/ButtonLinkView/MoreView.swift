//
//  MoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct MoreView: View {
    @Namespace var moreView
    @State var show: Bool = true
    
    let gridItems = Array(repeating: GridItem(.flexible(minimum: 50)), count: 4)
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItems){
                if show{
                    ForEach(0..<10){ index in
                        CardOfMoreView()
                            .aspectRatio(0.6, contentMode: .fit)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("更多功能")
        .navigationBarTitleDisplayMode(.inline)
    }
}


fileprivate struct CardOfMoreView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.orange)
    }
}


struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoreView()
                .previewDevice("iPad Pro (11-inch) (3rd generation)")
            MoreView()
                .previewDevice("iPhone 13 mini")
        }
    }
}
