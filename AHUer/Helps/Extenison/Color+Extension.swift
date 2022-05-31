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
    
    static var HeHuanRed: Color {
        return Color(r: 240, g: 161, b: 168)
    }
    
    static var babyPuerple: Color {
        return Color(r: 200, g: 136, b: 232)
    }
    
    static var meiOrange: Color {
        return Color(r: 253, g: 178, b: 81)
    }
    
    static var silver: Color {
        return Color(r: 200, g: 200, b: 200)
    }
    
    static var jintaiLan: Color {
        return Color(r: 39, g: 117, b: 182)
    }
    
    static var yuzan: Color {
        return Color(r: 164, g: 202, b: 182)
    }
    
    static var gemBlue: Color {
        return Color(r: 36, g: 134, b: 185)
    }
    
    static var RainBowBlue: Color {
        return Color(r: 33, g: 119, b: 184)
    }
    
    static var imageBlue: Color {
        return Color(r: 47, g: 131, b: 215)
    }
    
    //If BlackModel, return white ,WhiteModel return black
    static var background: Color{
        return Color(.systemBackground)
    }
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0)
    }
    
    static func courseColor(courseId: String) -> Color {
        if courseId.contains("ZH") {
            return .red
        } else if courseId.contains("ZX") {
            return .blue
        } else if courseId.contains("ZJ") {
            return .purple
        } else if courseId.contains("GG") {
            return .green
        } else if courseId.contains("TY") {
            return .yellow
        } else if courseId.contains("ADD") {
            return .skyBlue
        } else {
            return .orange
        }
    }
}

extension ColorScheme {
    var isLight: Bool {
        return self == .light
    }
}
