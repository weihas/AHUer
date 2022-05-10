//
//  AboutUSContributer.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/10.
//

import Foundation

enum ContributeType: Int, CaseIterable {
    case product
    case foreground
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
        case .foreground:
            return "前端"
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
        case .foreground:
            return "rectangle.and.hand.point.up.left"
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
            return ["郑琦","谢梦磊","吴思娴","石坤","刘子哲","王浩伟"]
        case .foreground:
            return ["谢梦磊","洪志高","ZJX","石坤","李阳","冯磊","朱凡","陈聪","付天辰","吴世博","王浩伟"]
        case .background:
            return ["石坤","刘子哲","刘瑞鹏","王渝川","吴振龙"]
        case .management:
            return ["吴思娴","毛依凡","吴越洋","刘子哲","欧立洋"]
        case .design:
            return ["郑琦","葛婷","熊彦超","焦雨辰","刘菲","陈柏潭","刘雯茜","王睿妍","王浩伟"]
        case .machineLearning:
            return ["张敬轩", "马昆昆"]
        case .thanks:
            return []
        }
    }
}
