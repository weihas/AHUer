//
//  Picker+Style.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI


struct CapsulePickStyle: View {
    @Binding var selectNum: Int
    var dataSource: [String]
    var body: some View{
        HStack{
            ForEach(dataSource.indices){ index in
                Spacer()
                Button(dataSource[index]){
                    selectNum = index
                }
                .buttonStyle(PickButtonStyle(isChoose: index == selectNum))
                Spacer()
            }
        }
    }
}

fileprivate struct PickButtonStyle: ButtonStyle {
    var isChoose: Bool
    
    public func makeBody(configuration: Self.Configuration) -> some View{
        configuration.label
            .font(.footnote)
            .foregroundColor(isChoose ? .white : .black)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.black)).opacity(isChoose ? 1 : 0.1))
            .compositingGroup()
            .opacity(configuration.isPressed ? 0.3 : 0.8)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
