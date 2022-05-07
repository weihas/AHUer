//
//  ScheduleAddLectureView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/19.
//

import SwiftUI

struct ScheduleAddLectureView: View {
    @ObservedObject var vm: ScheduleAddLectureShow = .init()
    var body: some View {
        VStack{
            TextField("name", text: $vm.name)
            TextField("location", text: $vm.location)
            TextField("teacher", text: $vm.teacher)
            ScrollView{
                Picker(selection: $vm.startTime, label: Text("开始时间")) {
                    Text("8:20").tag("1")
                    Text("10:20").tag("3")
                    Text("14:00").tag("5")
                    Text("15:50").tag("7")
                    Text("19:00").tag("9")
                    Text("20:50").tag("11")
                }
                .pickerStyle(.segmented)
                
                Picker(selection: $vm.weekDay, label: Text("星期几")) {
                    Text("周一").tag("1")
                    Text("周二").tag("2")
                    Text("周三").tag("3")
                    Text("周四").tag("4")
                    Text("周五").tag("5")
                    Text("周六").tag("6")
                    Text("周日").tag("7")
                }
                .pickerStyle(.segmented)
                
                Picker(selection: $vm.startTime, label: Text("时长")) {
                    Text("1").tag("1")
                    Text("2").tag("2")
                    Text("3").tag("3")
                    Text("4").tag("4")
                }
                .pickerStyle(.segmented)
            }
            Button("保存") {
                vm.addLecture()
            }
        }
        .padding()
    }
}

struct TimeScheduleAddLectureView_swift_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleAddLectureView()
    }
}
