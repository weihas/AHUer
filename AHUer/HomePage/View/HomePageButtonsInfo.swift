//
//  HomePageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI

class HomePageButtonsInfo: ObservableObject {
    @Published var buttons: [buttonData]
    private var titles: [String] = ["校招信息","校园电话","空闲教室","成绩查询","考场查询","共享课表","餐卡丢拾","浴室开放","垃圾分类","更多功能"]
    private var icons: [String] = ["paperplane.fill","phone.bubble.left.fill","building.columns.fill","doc.text.below.ecg.fill","signpost.right.fill","folder.fill.badge.person.crop","creditcard.fill","drop.fill","trash.fill","hand.point.up.braille.fill"]
    private var colors: [Color] = [Color.red,Color.blue,Color.green,Color.orange,Color.pink,Color.green,Color.yellow,Color.purple,Color.gray,Color.black]
    
    init() {
        buttons = []
        for index in titles.indices {
            buttons.append(buttonData(id: index, title: titles[index], icon: icons[index], color: colors[index]))
        }
    }
}

struct buttonData: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let color: Color
}
