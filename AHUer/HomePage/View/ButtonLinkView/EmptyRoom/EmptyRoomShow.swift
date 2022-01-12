//
//  EmptyRoomShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/21.
//

import Foundation

class EmptyRoomShow: ObservableObject {
    @Published var emptyRooms: [EmptyRoomSection] = []
    
    func search(campus: Int, weekday: Int, weekNum: Int, time: Int, _ completion: @escaping completion){
        AhuerAPIProvider.netRequest(.emptyRooms(campus: campus , weekday: weekday, weekNum: weekNum, time: time)) { [weak self] respon in
            guard let self = self else { return }
            print(respon?["msg"] as? String ?? "")
            if let statusNum = respon?["success"] as? Bool, statusNum == true, let rooms = respon?["data"] as? [[String: String]]{
                var result: [String :[EmptyRoom]] = [:]
                
                for (index,room) in rooms.enumerated(){
                    if let seating = room["seating"], let pos = room["pos"]{
                        let name = pos.filter({!$0.isASCII})
                        result.updateValue((result[name] ?? []) + [EmptyRoom(id: index, seating: seating, pos: pos)], forKey: name)
                    }
                }
                var sections: [EmptyRoomSection] = []
                var id = 0
                for (key,value) in result{
                    sections.append(EmptyRoomSection(id: id, name: key, rooms: value.sorted(by: {$0.pos < $1.pos})))
                    id += 1
                }
                self.emptyRooms = sections.sorted(by: {$0.name < $1.name})
            }
        } error: { error in
            completion(false,"空教室查询失败", error.description)
        }
    }
    
    deinit {
        print("🌀EmptyRoomShow released")
    }
}

struct EmptyRoomSection: Identifiable {
    var id: Int
    var name: String
    var rooms: [EmptyRoom]
}


struct EmptyRoom: Identifiable{
    var id: Int
    
    var seating: String
    var pos: String
}

enum Campus: Int {
    case Qinyuan = 1, LongHe = 2, Shushan = 5
    var id: Int{
        return self.rawValue
    }
  
}

enum LectureTime: Int, CaseIterable, Identifiable{
    var id: Int{
        return self.rawValue
    }
    case first = 1, second, third, forth, fifth, morning, afternoon, night, all
    
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

enum Weekday: Int, CaseIterable,Identifiable {
    case Mon = 1
    case Tues
    case Wed
    case Thur
    case Fri
    case Sat
    case Sun
    
    var id: Int{
        return self.rawValue
    }
    var description: String{
        switch self {
        case .Mon:
            return "周一"
        case .Tues:
            return "周二"
        case .Wed:
            return "周三"
        case .Thur:
            return "周四"
        case .Fri:
            return "周五"
        case .Sat:
            return "周六"
        case .Sun:
            return "周日"
        }
    }
}
