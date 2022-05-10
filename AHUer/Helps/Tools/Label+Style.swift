//
//  Label+Style.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/10.
//

import Foundation
import SwiftUI

struct SettingLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .foregroundColor(.accentColor)
                .frame(width: 28)
            configuration.title
                .foregroundColor(.primary)
        }
    }
}
