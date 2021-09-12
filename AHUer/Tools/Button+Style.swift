//
//  Button+Style.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/10.
//

import Foundation
import SwiftUI

public struct ColorButtonStyle: ButtonStyle {
    var color: Color
    
    public func makeBody(configuration: Self.Configuration) -> some View{
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 15).fill(color))
            .compositingGroup()
            .shadow(color: .gray, radius: 3)
            .opacity(configuration.isPressed ? 0.3 : 0.8)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
