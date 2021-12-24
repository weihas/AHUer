//
//  GroupBox+Style.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI

struct ColorBoxStyle: GroupBoxStyle {
    var backgroundColor: Color
    var opacityRate: Double = 0.6
    public func makeBody(configuration: Self.Configuration) -> some View{
        VStack{
            HStack{
                configuration.label
                    .padding()
                Spacer()
            }
            configuration.content
                .font(.footnote)
                .padding()
        }
        .foregroundColor(Color(.systemBackground))
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .opacity(0.8)
                .shadow(radius: 10)
            )
    }
    
}

struct ShortBoxStyle: GroupBoxStyle {
    var backgroundColor: Color
    var opacityRate: Double = 0.6
    public func makeBody(configuration: Self.Configuration) -> some View{
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.blue)
            .aspectRatio(2, contentMode: .fit)
            .shadow(radius: 10)
            .overlay(
                configuration.content
            )
    }
    
}
