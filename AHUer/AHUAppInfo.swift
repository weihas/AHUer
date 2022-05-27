//
//  AHUAppInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation
import SwiftUI

/// AHUer全应用共享参数
class AHUAppInfo: ObservableObject {
    @AppStorage(AHUerDefaultsKey.AHUID.rawValue, store: .standard) var userID: String = ""
    ///当前的tableItemNum
    @Published var tabItemNum: Int = 0
    @Published var isLoggin: Bool = false
    
    init() {}
    
    func freshLogginStatus() {
        isLoggin = (userID != "")
    }
    
    deinit{
        print("🌀AHUAppInfo released")
    }
}

enum TabPage: Int {
    case homePage
    case schedulePage
    case personal
}

extension TabPage: Identifiable, CaseIterable {
    var id: Int {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .homePage:
            return "主页"
        case .schedulePage:
            return "课表"
        case .personal:
            return "个人"
        }
    }
    
    var icon: String {
        switch self {
        case .homePage:
            return "house"
        case .schedulePage:
            return "list.bullet.rectangle"
        case .personal:
            return "person.circle"
        }
    }
    
    var title: String {
        switch self {
        case .homePage:
            return "今天"
        case .schedulePage:
            return "第十一周"
        case .personal:
            return "个人"
        }
    }
    
}





