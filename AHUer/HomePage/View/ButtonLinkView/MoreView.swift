//
//  MoreView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct MoreView: View {
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
    let cardInfo: CardInfo
    var body: some View {
        NavigationLink {
            
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.orange, lineWidth: 2)
                .overlay(Text("Hello"))
        }
    }
    
    @ViewBuilder
    func distination() -> some View {
        switch cardInfo.style{
        case .emptyRoom :
            EmptyRoomView(vm: cardInfo.viewModel)
        }
    }
    
    
    
}

struct CardInfo {
    typealias T: HomePageFunctionProtocol
    let color: Color
    let context: String
    let icon: String
    let style: FunctionStyle
    let viewModel: T
}

//struct MoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MoreView()
//                .previewDevice("iPad Pro (11-inch) (3rd generation)")
//            MoreView()
//                .previewDevice("iPhone 13 mini")
//        }
//    }
//}
