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
                .padding()
        }
        .foregroundColor(Color(.systemBackground))
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(backgroundColor)
                .blur(radius: 3)
                .opacity(opacityRate))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemBackground),lineWidth: 5)
                .shadow(color: Color.gray,radius: 2.0 ,x: 2 ,y: 2)
        )
    }
    
}

struct ShortBoxStyle: GroupBoxStyle {
    var backgroundColor: Color
    var opacityRate: Double = 0.6
    public func makeBody(configuration: Self.Configuration) -> some View{
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                configuration.label
                Spacer()
            }
            configuration.content
        }.padding()
        .foregroundColor(.black)
    }
    
}
