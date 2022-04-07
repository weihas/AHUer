//
//  LectureTime.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import Foundation

enum LectureTime: Int, CaseIterable {
    case first = 1, second, third, forth, fifth, morning, afternoon, night, all

}

extension LectureTime: Identifiable {
    var id: Int {
        return rawValue
    }
    
    
    var description: String {
        switch self {
        case .first:
            return "第1、2节"
        case .second:
            return "第3、4节"
        case .third:
            return "第5、6节"
        case .forth:
            return "第7、8节"
        case .fifth:
            return "第9、10节"
        case .morning:
            return "早上"
        case .afternoon:
            return "下午"
        case .night:
            return "晚上"
        case .all:
            return "全天"
        }
    }
}
