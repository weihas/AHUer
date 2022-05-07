//
//  ScheduleAddLectureView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/19.
//

import SwiftUI

struct ScheduleAddLectureView: View {
    @StateObject var vm: ScheduleAddLectureShow = .init()
    @Environment(\.colorScheme) var colorScheme
    @State private var weekNumChoose: Bool = false
    @State private var weekDayChoose: Bool = false
    @State private var timeChoose: Bool = false
    @State private var lengthChoose: Bool = false
    
    var body: some View {
        Group {
            TextField("name", text: $vm.name)
            TextField("location", text: $vm.location)
            TextField("teacher", text: $vm.teacher)
               
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        context
        Spacer()
        Button("ADD") {
            vm.addLecture()
        }
    }
    
    var context: some View {
        HStack{
            Picker(selection: $vm.startTime, label: Text("开始时间")) {
                ForEach(StartTime.allCases) { time in
                    Text(time.description).tag(time)
                }
            }
            
            Picker(selection: $vm.weekDay, label: Text("星期几")) {
                ForEach(Weekday.allCases) { day in
                    Text(day.completeDescription).tag(day)
                }
            }
            
            Picker(selection: $vm.length, label: Text("时长")) {
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
            }
           
        }
        .pickerStyle(.menu)
        .padding()
    }
}

struct TimeScheduleAddLectureView_swift_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleAddLectureView()
    }
}
