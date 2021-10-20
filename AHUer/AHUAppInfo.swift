//
//  AHUAppInfo.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/11.
//

import Foundation

class AHUAppInfo: ObservableObject {
    @Published var isLoggin: Bool = false
    @Published var tabItemNum: Int = 0
    @Published private var todayModel: TodayMessages
    @Published var lectures: [Course] = []
    
    
    init() {
        todayModel = TodayMessages()
    }
    
    var gpa: (Double,Double){
        return todayModel.gpa
    }
    
    var todayLectures: [Course]{
        return todayModel.lectures
    }
    
    var southBathroomisMen: Bool{
        return todayModel.southBathroomisMen
    }
    
    var firstlectureName: String {
        guard let name = todayModel.lectures.first?.name else { return "未导入课程或尚未选课" }
        return name
    }
    
    var firstlectureLocation: String {
            guard let location = todayModel.lectures.first?.location else { return "暂无数据" }
            return location
    }
    
    var firstlectureTime: String {
//        guard let start = todayModel.lectures.first?.startTime,
//              let end = todayModel.lectures.first?.endTime
//        else { return "0-0" }
        return "12:30" + "~" + "13:40"
    }
    
    var logginName: String {
        return "E01814133"
    }
}



