//
//  BathRoom.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/27.
//

import Foundation
import MapKit
import SwiftUI

enum BathRoom: Int, CaseIterable {
    case Zhu
    case Ju
    case Hui
}

extension BathRoom: Identifiable {
    var id: Int {
        self.rawValue
    }
    
    var name: String {
        switch self {
        case .Zhu:
            return "竹园浴室"
        case .Ju:
            return "桔园浴室"
        case .Hui:
            return "蕙园浴室"
        }
    }
    
    var defaultsKey: String {
        return AHUerDefaultsKey.BathRoom.rawValue + "_" + "\(self.rawValue)"
    }
    
    
    var openState: String {
        guard let state = UserDefaults.standard.string(forKey: defaultsKey) else { return "请刷新网络"}
        if state == "m" {
            return "男"
        } else if state == "w" {
            return "女"
        } else if state == "wm" {
            return "男 && 女"
        } else  {
            return "请刷新网络"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .Zhu:
            return .init(latitude: 31.76395, longitude: 117.1821)
        case .Ju:
            return .init(latitude: 31.76976, longitude: 117.1819)
        case .Hui:
            return .init(latitude: 31.77393, longitude: 117.1883)
        }
    }
    
    var color: LinearGradient {
        guard let state = UserDefaults.standard.string(forKey: defaultsKey) else { return  LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing)}
        var colors: [Color] = []
        if state.contains("m") {
            colors.append(.blue)
        }
        
        if state.contains("w") {
            colors.append(.pink)
        }
        
        if colors.isEmpty {
            colors.append(.gray)
        }
        
        return LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
    
    init?(name: String) {
        if name == "竹园浴室" {
            self.init(rawValue: 0)
        } else if  name == "桔园浴室" {
            self.init(rawValue: 1)
        } else if  name == "蕙园浴室" {
            self.init(rawValue: 2)
        } else {
            return nil
        }
    }
}
