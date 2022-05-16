//
//  ScheduleAddLectureShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/5/7.
//

import SwiftUI

class ScheduleAddLectureShow: ObservableObject {
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var teacher: String = ""
    
    @Published var length: Int = 2
    @Published var singleDouble: Bool = false
    @Published var startTime: StartTime = .one
    @Published var startWeek: Int = 1
    @Published var endWeek: Int = 18
    @Published var weekDay: Weekday = .Mon

    
    //MARK: -Access to Model
    
    var lecturetoAdd: [String:Any] {
        let courseId = "ADD" + UUID().description.prefix(8)
        let attributeInfo = ["name": name, "location": location, "teacher": teacher, "weekday": weekDay.rawValue, "startTime" : startTime.rawValue, "length": "\(length)", "courseId": courseId, "startWeek": startWeek, "endWeek": endWeek] as [String : Any]
        return attributeInfo
    }
    
    //MARK: -Intent(s)
    
    func addLecture(){
        guard let user = Student.nowUser() else { return }
        
        if let result = Course.fetch(by: NSPredicate(format: "name = %@", name)), !result.isEmpty {
            result.first?.update(of: lecturetoAdd)?.beHold(of: user)
            return
        }
        
        Course.insert()?.update(of: lecturetoAdd)?.beHold(of: user)
    }
}

//"weekday": "周几",
//      "startWeek": "开始的周",
//      "endWeek": "结束的周",
//      "extra": "附加信息默认为空",
//      "location": "上课地点",
//      "name": "课程名称",
//      "teacher": "老师姓名",
//      "length": "课程长度（几节课）",
//      "startTime": "开始时间（第几节开始）",
//      "singleDouble": "是否单双周。0为否，1为是",
//      "courseId": "课程代码"
