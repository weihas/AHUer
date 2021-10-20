//
//  TimeTable.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import Foundation

struct TimeTable {
    var tableClassCellModels: [[TableClassCellModel]]
    
    init(){
        tableClassCellModels = []
        var id = 0
        for _ in 0..<11{
            var sequence: [TableClassCellModel] = []
            for _ in 0..<7{
                sequence.append(TableClassCellModel(id: id, name: "", location: "", lectureLengthisTwo: true))
                id += 1
            }
            tableClassCellModels.append(sequence)
            sequence.removeAll()
        }
        
        
        tableClassCellModels[2][3].changeInfo(name: "高等数学", location: "博北A401")
        tableClassCellModels[0][0].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: false)
        tableClassCellModels[0][1].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: false)
        tableClassCellModels[0][2].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: false)
        tableClassCellModels[0][3].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: false)
        tableClassCellModels[0][4].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: false)
        tableClassCellModels[0][5].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: true)
        tableClassCellModels[0][6].changeInfo(name: "大学物理", location: "博北A201", lectureLengthisTwo: false)
        tableClassCellModels[8][1].changeInfo(name: "英语", location: "博南C201")
    }
}


struct TableClassCellModel: Identifiable{
    var id: Int
    
    var name: String
    var location: String
    var isShow: Bool{get {name != ""} }
    var lectureLengthisTwo: Bool
    
    mutating func changeInfo(name: String, location: String, lectureLengthisTwo: Bool = true){
        self.name = name
        self.location = location
        self.lectureLengthisTwo = lectureLengthisTwo
    }
    
}

struct Weekday {
    var day: Day
    var lectures: [Course]

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
