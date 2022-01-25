//
//  MoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct MoreView: View {
    @Namespace var moreView
    @State var show: Bool = false
    var body: some View {
        VStack{
            if show{
            ForEach(0..<10){ index in
                CardOfMoreView()
            }
            }
        }
        .navigationTitle("更多功能")
        .navigationBarTitleDisplayMode(.inline)
    }
}


fileprivate struct CardOfMoreView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
    }
}


struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
