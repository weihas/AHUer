//
//  HomePageInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/12.
//

import Foundation
import SwiftUI

struct HomePageInfo {
    var nextCourse: Course?
    var northBathroomisMen: Bool
    var gpa: (thisGrade: Double , all: Double)
    
    var buttonsInfo: [ButtonInfo]
    
    init() {
        northBathroomisMen = true
        gpa = (5.0,4.0)
        buttonsInfo = ButtonInfo.buttonInfos
    }
    
    mutating func fetchImmediatelyLecture(){
        let today = Date()
        //TODO: -
        guard let user = Student.nowUser() else {nextCourse = nil; return}
        //        let predicete = NSPredicate(format: "owner = %@", user)
        let predicete = NSPredicate(format: "owner = %@ AND startWeek <= %@ AND endWeek >= %@ AND weekday = %@ AND startTime >= %@", user, NSNumber(value: today.studyWeek), NSNumber(value: today.studyWeek), NSNumber(value: today.weekDay), NSNumber(value: today.startTime ))
        guard let courses = Course.fetch(by: predicete, sort: ["startTime" : true]) else { nextCourse = nil ; return }
        nextCourse = courses.first
    }
}

struct ButtonInfo: Identifiable{
    static let buttonInfos: [ButtonInfo] = [
        ButtonInfo(id: 0, name: "空闲教室", icon: "building.columns.fill", color: Color.red),
        ButtonInfo(id: 1, name: "成绩查询", icon: "doc.text.below.ecg.fill", color: Color.orange),
        ButtonInfo(id: 2, name: "考场查询", icon: "signpost.right.fill", color: Color.green),
        ButtonInfo(id: 3, name: "浴室开放", icon: "drop.fill", color: Color.purple),
        ButtonInfo(id: 4, name: "成绩分布", icon: "chart.pie.fill", color: Color.meiRed),
        ButtonInfo(id: 5, name: "更多功能", icon: "hand.point.up.braille.fill", color: Color.gray)
    ]
    let id: Int
    let name: String
    let icon: String
    let color: Color
}

enum FunctionStyle: CaseIterable {
    case emptyRoom
    case scoreSearch
    case examSearh
    case bathroom
    case distribution
    case more
    case addressbook
    
    var funcName: String{
        return ""
    }
}

protocol HomePageFunctionProtocol: ObservableObject {
    var style: FunctionStyle { get set }
}

class EmptyShow: HomePageFunctionProtocol {
    
    var style: FunctionStyle = .emptyRoom
    
    @Published var emptyRooms: [EmptyRoomSection] = []
    
    func search(campus: Int, weekday: Int, weekNum: Int, time: Int) async throws{
        let respon = try await AHUerAPIProvider.asyncRequest(.emptyRooms(campus: campus, weekday: weekday, weekNum: weekNum, time: time))
        print(respon["msg"].stringValue)
        guard respon["success"].boolValue else { return }
        
        let rooms = respon["data"].arrayValue
        
        var result: [String :[EmptyRoom]] = [:]
        
        for (index,room) in rooms.enumerated(){
            if let seating = room["seating"].string, let pos = room["pos"].string {
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
        sections.sort(by: {$0.name < $1.name})
        
        await MainActor.run { [sections] in
            self.emptyRooms = sections
        }
    }
    
    deinit {
        print("🌀EmptyRoomShow released")
    }
    
}

