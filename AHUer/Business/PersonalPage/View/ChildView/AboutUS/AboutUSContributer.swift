//
//  AboutUSContributer.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/10.
//

import Foundation

enum ContributeType: Int, CaseIterable {
    case product
    case background
    case management
    case design
    case machineLearning
    case thanks
}

extension ContributeType: Identifiable {
    var id: Int {
        return rawValue
    }
    
    var name: String {
        switch self {
        case .product:
            return "产品"
        case .background:
            return "后端"
        case .management:
            return "运营"
        case .design:
            return "设计"
        case .machineLearning:
            return "机器学习"
        case .thanks:
            return "致谢"
        }
    }
    
    var icon: String {
        switch self {
        case .product:
            return "brain.head.profile"
        case .background:
            return "brain.head.profile"
        case .management:
            return "brain.head.profile"
        case .design:
            return "brain.head.profile"
        case .machineLearning:
            return "brain.head.profile"
        case .thanks:
            return "brain.head.profile"
        }
    }
    
    var member: [String] {
        switch self {
        case .product:
            return ["王浩伟"]
        case .background:
            return ["吴振龙", "徐海", "王岳赣", "王壮壮"]
        case .management:
            return []
        case .design:
            return ["王浩伟"]
        case .machineLearning:
            return ["张敬轩", "马昆昆"]
        case .thanks:
            return []
        }
    }
}
