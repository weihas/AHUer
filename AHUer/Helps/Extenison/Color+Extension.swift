//
//  Color+Extension.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/21.
//

import Foundation
import SwiftUI

extension Color{
    static var random: Color{
        let colors: [Color] = [.red,.blue,.green,.pink,.orange,.purple,.yellow]
        return colors.randomElement() ?? .blue
        
    }
    static var meiRed: Color{
        return Color(r: 221, g: 160, b: 221)
    }
    
    static var gold: Color{
        return Color(r: 255, g: 215, b: 0)
    }
    
    static var birdBlue: Color{
        return Color(r: 51, g: 161, b: 201)
    }
    
    static var skyBlue: Color{
        return Color(r: 135, g: 206, b: 235)
    }
    
    static var jasoa: Color{
        return Color(r: 160, g: 102, b: 211)
    }
    
    static var darkGray: Color {
        return Color(r: 91, g: 90, b: 96)
    }
    
    static var lightGray: Color {
        return Color(r: 238, g: 238, b: 238)
    }
    
    //If BlackModel, return white ,WhiteModel return black
    static var background: Color{
        return Color(.systemBackground)
    }
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0)
    }
}

extension ColorScheme {
    var isLight: Bool {
        return self == .light
    }
}
