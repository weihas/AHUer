//
//  ScheduleView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var vm: ScheduleShow
    @Namespace var changenameSpace
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
              dateLineView
                if vm.gridModel {
                    scheduleGridView
                } else {
                    scheduleListView
                }
            }
            .onTapGesture(count: 2) {
                withAnimation {
                    vm.gridModel.toggle()
                }
            }
            .onTapGesture {
                withAnimation {
                    if vm.gridModel {
                        vm.showTimeLine.toggle()
                    }
                }
            }
            .sheet(isPresented: $vm.showAddLecture) {
                TimeScheduleAddLectureView()
            }
            .onAppear {
                vm.freshModel()
            }
            .toolbar{
                toolbarContent
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker(selection: $vm.selectedTerm, label: Text(vm.selectedTerm.title)) {
                        ForEach(ScheduleShow.LearningTerm.allCases) { term in
                            Text(term.title).tag(term)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("第\(Date().studyWeek)周")
           
        }
        .navigationViewStyle(.stack)
    }
    
    //日期视图
    private var dateLineView: some View {
        LazyVGrid(columns: vm.items) {
            ForEach(vm.weekdays, id: \.id) { day in
                VStack {
                    if day.isTimeLine {
                        timeLinetitle
                    } else {
                        Group{
                            Text(day.weekday?.description ?? "Time")
                            ZStack{
                                Circle()
                                    .fill(day.weekday == vm.selectedDay ? Color.primary : Color.clear)
                                Text("\(day.date.day)")
                                    .foregroundColor(day.weekday == vm.selectedDay ? Color(UIColor.systemBackground) : Color.primary)
                                    .padding(3)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                guard let weekday = day.weekday else { return }
                                vm.selectedDay(day: weekday)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var timeLinetitle: some View {
        VStack {
            Text("Time")
                .fixedSize()
            Image(systemName: "clock")
                .padding(3)
        }
    }
    
    private var toolbarContent: some View {
        HStack{
            Button {
                withAnimation {
                    vm.changeSkimModel()
                }
            } label: {
                Label("模式切换", systemImage: vm.gridModel ? "tablecells.fill" : "tablecells")
            }

            
            Menu {
                // TODO: 课表
                Button {
                    vm.addSchedule()
                } label: {
                    Label("手动添加", systemImage: "plus.rectangle.on.rectangle")
                }
                Button {
                    vm.freshScheduleInternet()
                } label: {
                    Label("刷新课表", systemImage: "globe.europe.africa")
                }

                Button {
                    vm.cleanUp()
                } label: {
                    Label("清除课表", systemImage: "trash")
                }

            } label: {
                Label("More", systemImage: "ellipsis")
            }
        }
    }
    
    private var scheduleGridView: some View {
        LazyVGrid(columns: vm.items) {
            ForEach(vm.weekdays) { weekday in
                ScheduleDayView(day: weekday, namespace: changenameSpace)
            }
        }
        .onDisappear{
            vm.showTimeLine = false
        }
        .padding(.horizontal)
    }
    
    private var scheduleListView: some View {
        ScheduleGalleryView(namespace: changenameSpace, day: vm.galleryDay)
    }
}





struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ScheduleShow()
        vm.freshModel()
        return ScheduleView(vm: ScheduleShow())
    }
}
