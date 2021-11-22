//
//  EmptyClassShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/21.
//

import Foundation

class EmptyClassShow: ObservableObject {
    @Published var campus: Campus = .Qinyuan
    @Published var time: LectureTime = .first
    
    @Published var emptyRooms: [EmptyRoom] = []
    
    func search(){
//        provider.getEmptyRoom(campus: campus, weekNum: 1, weekday: 10, time: time) { [weak self] status, data in
//            guard status.0 == 0, let rooms = data as? [[String: String]] else {return}
//            for (index,room) in rooms.enumerated(){
//                if let seating = room["seating"], let pos = room["pos"]{
//                    self?.emptyRooms.append(EmptyRoom(id: index, seating: seating, pos: pos))
//                }
//            }
//        }
    }
    
    deinit {
        print("🌀EmptyClassShow released")
    }
}

struct EmptyRoom: Identifiable{
    var id: Int
    
    var seating: String
    var pos: String
}

enum Campus {
    case LongHe, Qinyuan
}

enum LectureTime: CaseIterable, Identifiable{
    var id: Int{
        return self.hashValue
    }
    
    case first, second, third, forth, fifth, morning, afternoon, night, all
    
    var description: String{
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
