//
//  ScheduleAddLectureView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/19.
//

import SwiftUI

struct ScheduleAddLectureView: View {
    enum Field: Hashable {
        case nameField
        case locationField
        case teacherField
    }
    
    @StateObject var vm: ScheduleAddLectureShow = .init()
    @Environment(\.colorScheme) var colorScheme
    @State private var weekNumChoose: Bool = false
    @State private var weekDayChoose: Bool = false
    @State private var timeChoose: Bool = false
    @State private var lengthChoose: Bool = false
    @FocusState private var focusedField: Field?
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack {
          
            Form {
                Section {
                    TextField("name", text: $vm.name)
                        .focused($focusedField, equals: .nameField)
                } header: {
                    Text("课程名称")
                }
                Section {
                    TextField("location", text: $vm.location)
                        .focused($focusedField, equals: .locationField)
                } header: {
                    Text("位置")
                }
                Section {
                    TextField("teacher", text: $vm.teacher)
                        .focused($focusedField, equals: .teacherField)
                } header: {
                    Text("老师")
                }
            }
            context
            Button {
                if vm.name.isEmpty {
                    focusedField = .nameField
                } else if vm.location.isEmpty {
                    focusedField = .locationField
                } else if vm.teacher.isEmpty{
                    focusedField = .teacherField
                } else {
                    vm.addLecture()
                    present.wrappedValue.dismiss()
                }
            } label: {
                Label("添加", systemImage: "plus.app.fill")
            }
            .padding()
           
        }
    }
    
    var context: some View {
        HStack(spacing: 0) {
            Spacer()
            Text("开始时间: ")
            Picker(selection: $vm.startTime, label: Text("开始时间")) {
                ForEach(StartTime.allCases) { time in
                    Text(time.description).tag(time)
                }
            }
            Spacer()
            Text("周")
            Picker(selection: $vm.weekDay, label: Text("星期几")) {
                ForEach(Weekday.allCases) { day in
                    Text(day.description).tag(day)
                }
            }
            Spacer()
            Text("持续时长:")
            Picker(selection: $vm.length, label: Text("时长")) {
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
                Text("4").tag(4)
            }
            Spacer()
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
