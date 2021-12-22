//
//  TimeScheduleAddLectureView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/19.
//

import SwiftUI

struct TimeScheduleAddLectureView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    
    @State var name: String = ""
    @State var location: String = ""
    @State var teacher: String = ""
    @State var singleDouble: String = ""
    @State var startTime: String = ""
    @State var startWeek: String = ""
    @State var weekDay: String = ""
    @State var length: String = ""
    var body: some View {
        VStack{
            TextField("name", text: $name)
            TextField("location", text: $location)
            TextField("teacher", text: $teacher)
            ScrollView{
                Picker(selection: $startTime, label: Text("开始时间")) {
                    Text("8:20").tag("1")
                    Text("10:20").tag("3")
                    Text("14:00").tag("5")
                    Text("15:50").tag("7")
                    Text("19:00").tag("9")
                    Text("20:50").tag("11")
                }
                .pickerStyle(WheelPickerStyle())
                
                Picker(selection: $weekDay, label: Text("星期几")) {
                    Text("周一").tag("1")
                    Text("周二").tag("2")
                    Text("周三").tag("3")
                    Text("周四").tag("4")
                    Text("周五").tag("5")
                    Text("周六").tag("6")
                    Text("周日").tag("7")
                }
                .pickerStyle(WheelPickerStyle())
                
                Picker(selection: $startTime, label: Text("时长")) {
                    Text("1").tag("1")
                    Text("2").tag("2")
                    Text("3").tag("3")
                    Text("4").tag("4")
                }
                .pickerStyle(WheelPickerStyle())
            }
            Button("保存") {
                addLecture()
            }
        }
        .padding()
    }
    
    func addLecture(){
        guard let user = Student.nowUser(),let result = Course.fetch(by: NSPredicate(format: "name = %@", name)) else { return }
        let attributeInfo = ["name": name, "location": location, "teacher": teacher, "weekday": weekDay, "startTime" : startTime, "length": length]
        if result.isEmpty{
            Course.insert()?.update(of: attributeInfo)?.beHolded(by: user)
        }else{
            result[0].update(of: attributeInfo)?.beHolded(by: user)
        }
    }
    
}

struct TimeScheduleAddLectureView_swift_Previews: PreviewProvider {
    static var previews: some View {
        TimeScheduleAddLectureView()
    }
}
