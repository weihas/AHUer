//
//  TimeScheduleAddLectureView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/19.
//

import SwiftUI

struct TimeScheduleAddLectureView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @Environment(\.managedObjectContext) private var viewContext
    
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
        guard let result = Course.fetch(context: self.viewContext, predicate: ("name = %@",name)) else { return }
        let attributeInfo = ["name": name, "location": location, "teacher": teacher, "weekday": weekDay, "startTime" : startTime, "length": length]
        do{
            if result.isEmpty{
                let course = Course.insert(context: self.viewContext)?.update(context: self.viewContext, attributeInfo: attributeInfo)
                course?.owner = Student.fetch(context: self.viewContext, predicate: appInfo.whoAmIPredicate)?[0]
                try self.viewContext.save()
            }else{
                result[0].update(context: self.viewContext, attributeInfo: attributeInfo)
                result[0].owner = Student.fetch(context: self.viewContext, predicate: appInfo.whoAmIPredicate)?[0]
                try self.viewContext.save()
            }
        }catch{
            print("error")
        }
    }
    
}

struct TimeScheduleAddLectureView_swift_Previews: PreviewProvider {
    static var previews: some View {
        TimeScheduleAddLectureView()
    }
}