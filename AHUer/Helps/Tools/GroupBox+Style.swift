//
//  GroupBox+Style.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI

/// 用于主页的模块化方块
struct ModuleBoxStyle: GroupBoxStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        VStack(alignment: .leading){
            configuration.label
            configuration.content
        }
    }
}



/// 多彩Tips方块
struct ColorBoxStyle: GroupBoxStyle {
    var backgroundColor: Color
    
    init(_ backgroundColor: Color ) {
        self.backgroundColor = backgroundColor
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View{
        VStack(alignment: .leading){
            configuration.label
                .padding()
            configuration.content
                .font(.footnote)
                .padding()
        }
      
        .foregroundColor(Color.background)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .opacity(0.8)
                .shadow(radius: 10)
            )
        .padding()
    }
    
}

struct MoreBoxStyle: GroupBoxStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading){
            configuration.label
            configuration.content
        }
        .padding()
    }
}
