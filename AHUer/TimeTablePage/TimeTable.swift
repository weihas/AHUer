//
//  TimeTable.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

struct TimeTable {
}


struct Weekday {
    var day: Day
    var lectures: [Lecture]

    func getLectureVision(){
        
    }
}

struct classData {
    var weekday = "周几"
    var startWeek = "开始的周"
    var endWeek =  "结束的周"
    var extra =  "附加信息默认为空"
    var location = "上课地点"
    var name = "课程名称"
    var teacher =  "老师姓名"
    var length =  "课程长度（几节课）"
    var startTime =  "开始时间（第几节开始）"
    var singleDouble =  "是否单双周。0为否，1为是"
    var courseId =  "课程代码"
}
