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
    @Environment(\.colorScheme) var colorScheme
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            moduleChooseView
            dateLineView
            Group {
                if vm.gridModel {
                    scheduleGridView
                } else {
                    scheduleListView
                }
            }
        }
        .onTapGesture(count: 2) {
            vm.toggleTimeLine()
        }
        .animation(.easeInOut, value: vm.gridModel || vm.hideWeekend || vm.showTimeLine)
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
//        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.freshModel()
        }
    }
    
    private var moduleChooseView: some View {
        Picker(selection: $vm.gridModel) {
            Text("Day").tag(false)
            Text("Weak").tag(true)
        } label: {
            Text("Choose")
        }
        .pickerStyle(.segmented)
        .padding([.horizontal,.bottom])
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
        Picker(selection: $vm.selectedTerm) {
            ForEach(vm.showTerms) { term in
                Text(term.title).tag(term)
            }
        } label: {
            Text(vm.selectedTerm.title)
        }
        .padding(.horizontal, 7)
        .background(RoundedRectangle(cornerRadius: 7).stroke(colorScheme.isLight ? Color.lightGray : Color.darkGray))
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
            if vm.gridModel {
                Toggle(isOn: $vm.showTimeLine) {
                    Label("显示时间", systemImage: "timelapse")
                }
            }
            Toggle(isOn: $vm.hideWeekend) {
                Label("隐藏周末", systemImage: "cloud.sun")
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
