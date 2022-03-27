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
                if vm.skimModelisList {
                    scheduleListView
                } else {
                    ScheduleGalleryView(namespace: changenameSpace, day: vm.galleryDay)
                }
            }
            .onTapGesture {
                withAnimation {
                    if vm.skimModelisList {
                        vm.showTimeLine.toggle()
                    }
                }
            }
            .onAppear {
                vm.freshModel()
            }
            .toolbar{
                toolbarContent
            }
            .navigationTitle("第\(Date().studyWeek)周")
           
        }
        .navigationViewStyle(.stack)
    }
    
    private var dateLineView: some View {
        LazyVGrid(columns: vm.items) {
            ForEach(vm.weekdays, id: \.id) { day in
                VStack {
                    if day.isTimeLine {
                        timeLinetitle
                    } else {
                        Group{
                            Text(day.weekday.description)
                            ZStack{
                                Circle()
                                    .fill(day.weekday == vm.selectedData ? Color.primary : Color.clear)
                                Text("\(day.date.day)")
                                    .foregroundColor(day.weekday == vm.selectedData ? Color(UIColor.systemBackground) : Color.primary)
                                    .padding(3)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                vm.selectedDay(day: day.weekday)
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
            Image(systemName: "clock")
                .padding(5)
        }
    }

    
    
    private var toolbarContent: some View {
        HStack{
            Button {
                withAnimation {
                    vm.changeSkimModel()
                }
            } label: {
                Label("模式切换", systemImage: "square.on.circle")
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
    
    private var scheduleListView: some View {
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
}





struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ScheduleShow()
        vm.freshModel()
        return ScheduleView(vm: ScheduleShow())
    }
}
