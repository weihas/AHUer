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
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .shadow(radius: 10)
            )
    }
    
}

struct ShortBoxStyle: GroupBoxStyle {
    var backgroundColor: Color
    var opacityRate: Double = 0.6
    public func makeBody(configuration: Self.Configuration) -> some View{
        HStack{
            configuration.label
            Spacer()
        }
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.purple)
            .aspectRatio(2, contentMode: .fit)
            .overlay(
                HStack{
                    configuration.content
                        .padding()
                    Spacer()
                }
            )
    }
    
}
