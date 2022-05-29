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
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            dateLineView
            if vm.gridModel {
                scheduleGridView
            } else {
                scheduleListView
            }
        }
        .gesture(
            mixGesture
        )
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                termPicker
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarContent
            }
        }
        
        .alert("清空课表", isPresented: $showAlert) {
            Button(role: .cancel) {
                print("Cancel")
            } label: {
                Text("取消")
            }
            Button(role: .destructive) {
                vm.cleanUp()
            } label: {
                Text("确定")
            }
        } message: {
            Text("清空课表会导致所有课表数据被删除")
        }
        
        .sheet(isPresented: $vm.showEditView) {
            ScheduleAddLectureView()
                .onDisappear {
                    vm.freshModel()
                }
        }
        .onAppear {
            vm.freshModel()
        }
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
    
    private var mixGesture: some Gesture {
        ExclusiveGesture(
            TapGesture(count: 2)
                .onEnded {
                    withAnimation {
                        vm.gridModel.toggle()
                    }
                }
            ,
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    withAnimation {
                        if vm.gridModel {
                            vm.showTimeLine = value.location.x > value.startLocation.x
                        }
                    }
                }
        )
    }
    
    /// 时间表的指示
    private var timeLinetitle: some View {
        VStack {
            Text("Time")
                .fixedSize()
            Image(systemName: "clock")
                .padding(3)
        }
    }
    
    
    /// 网格模式
    private var scheduleGridView: some View {
        LazyVGrid(columns: vm.items) {
            ForEach(vm.weekdays) { weekday in
                ScheduleDayView(day: weekday, namespace: changenameSpace)
                    .environmentObject(vm)
            }
        }
        .onDisappear{
            vm.showTimeLine = false
        }
        .padding(.horizontal)
    }
    
    ///列表模式
    private var scheduleListView: some View {
        ScheduleGalleryView(namespace: changenameSpace, day: vm.galleryDay)
    }
    
}


//MARK: -ToolBar
extension ScheduleView {
    //学期选择
    private var termPicker: some View {
        Picker(selection: $vm.selectedTerm, label: Text(vm.selectedTerm.title)) {
            ForEach(vm.showTerms) { term in
                Text(term.title).tag(term)
            }
        }
        .pickerStyle(.menu)
    }
    
    ///‘更多’按钮
    private var toolbarContent: some View {
        Menu {
            // TODO: 课表
            Button {
                vm.showEditView.toggle()
            } label: {
                Label("手动添加", systemImage: "plus.rectangle.on.rectangle")
            }
            Button {
                vm.freshScheduleInternet()
            } label: {
                Label("刷新课表", systemImage: "globe.europe.africa")
            }
            
            Button {
                showAlert.toggle()
            } label: {
                Label("清除课表", systemImage: "trash")
            }
            Divider()
            Toggle(isOn: $vm.gridModel) {
                Label("网格模式", systemImage: "tablecells")
            }
        } label: {
            Label("More", systemImage: "tablecells.badge.ellipsis")
        }
    }
}



struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ScheduleShow()
        vm.freshModel()
        return ScheduleView(vm: ScheduleShow())
    }
}
