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
}
