//
//  HomePageFunc.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/19.
//

import SwiftUI

enum HomePageFuncTag {
    case study
    case life
    case showInHome
    case showInMore
}

enum HomePageFunc: Int, Identifiable, CaseIterable {
    var id: Int {
        return self.rawValue
    }
    
    case emptyRoom = 0
    case scoreSearch = 1
    case examSearh
    case bathroom
    case distribution
    case more
    case addressbook
    case cardBalance
    
    var tag: Set<HomePageFuncTag> {
        switch self {
        case .emptyRoom:
            return [.study, .showInHome, .showInMore]
        case .scoreSearch:
            return [.study, .showInHome, .showInMore]
        case .examSearh:
            return [.study, .showInHome, .showInMore]
        case .bathroom:
            return [.life, .showInHome, .showInMore]
        case .distribution:
            return [.study, .showInHome, .showInMore]
        case .more:
            return [.showInHome]
        case .addressbook:
            return [.life, .showInMore]
        case .cardBalance:
            return [.life, .showInMore]
        }
    }
    
}


extension HomePageFunc {
    
    var funcName: String{
        switch self {
        case .emptyRoom:
            return "空闲教室"
        case .scoreSearch:
            return "成绩查询"
        case .examSearh:
            return "考试查询"
        case .bathroom:
            return "浴室查询"
        case .distribution:
            return "成绩分布"
        case .addressbook:
            return "校园电话"
        case .more:
            return "更多功能"
        case .cardBalance:
            return "饭卡余额"
        }
        
    }
    
    var funcIcon: String {
        switch self {
        case .emptyRoom:
            return "building.columns.fill"
        case .scoreSearch:
            return "doc.text.below.ecg.fill"
        case .examSearh:
            return "signpost.right.fill"
        case .bathroom:
            return "drop.fill"
        case .distribution:
            return "chart.pie.fill"
        case .more:
            return "hand.point.up.braille.fill"
        case .addressbook:
            return "phone.circle.fill"
        case .cardBalance:
            return "creditcard.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .emptyRoom:
            return .red
        case .scoreSearch:
            return .orange
        case .examSearh:
            return .green
        case .bathroom:
            return .purple
        case .distribution:
            return .meiRed
        case .more:
            return .gray
        case .addressbook:
            return .birdBlue
        case .cardBalance:
            return .yellow
        }
    }
}
