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
    @State var skimModelisList: Bool = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if skimModelisList {
                    scheduleListView
                } else {
                    ScheduleGalleryView(namespace: changenameSpace, day: vm.galleryDay)
                }
            }
            .onTapGesture {
                withAnimation {
                    if skimModelisList {
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
    
 
    
    private var toolbarContent: some View {
        HStack{
            Button {
                withAnimation {
                    skimModelisList.toggle()
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
