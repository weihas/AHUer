//
//  EmptyRoomShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/21.
//

import Foundation

class EmptyRoomShow: ObservableObject {
    @Published var emptyRooms: [EmptyRoomSection] = []
    
    init() {
        print("🎈 EmptyRoomShow init")
    }
    
    func search(campus: Int, weekday: Int, weekNum: Int, time: Int){
        
        Task{
            do {
                let respon = try await AHUerAPIProvider.asyncRequest(.emptyRooms(campus: campus, weekday: weekday, weekNum: weekNum, time: time))
                
                let rooms = respon["data"].arrayValue
                
                var result: [String : [EmptyRoomSection.EmptyRoom]] = [:]
                
                for (index,room) in rooms.enumerated(){
                    if let seating = room["seating"].string, let pos = room["pos"].string {
                        let name = pos.filter({!$0.isASCII})
                        result.updateValue((result[name] ?? []) + [EmptyRoomSection.EmptyRoom(id: index, seating: seating, pos: pos)], forKey: name)
                    }
                }
                var sections: [EmptyRoomSection] = []
                var id = 0
                for (key,value) in result{
                    sections.append(EmptyRoomSection(id: id, name: key, rooms: value.sorted(by: {$0.pos < $1.pos})))
                    id += 1
                }
                await MainActor.run { [sections] in
                    self.emptyRooms = sections.sorted(by: {$0.name < $1.name})
                }
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    deinit {
        print("🌀EmptyRoomShow released")
    }
    
    struct EmptyRoomSection: Identifiable {
        var id: Int
        var name: String
        var rooms: [EmptyRoom]
        
        struct EmptyRoom: Identifiable{
            var id: Int
            
            var seating: String
            var pos: String
        }
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



enum Campus: Int {
    case Qinyuan = 1, LongHe = 2, Shushan = 5
    var id: Int{
        return self.rawValue
    }
  
}
