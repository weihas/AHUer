//
//  TimeTablePage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct TimeSchedulePageView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: TimeScheduleShow
    
    @State var addSchedule: Bool = false
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                HStack(alignment: .top){
                    timeline.frame( maxWidth: 60)
                    ForEach(vm.timetableInfos, id: \.id){ info in
                        ClassInOneDayView(model: info)
                    }
                    Spacer()
                }
            }
            .onAppear{
                vm.freshDataOfClass()
            }
            .toolbar{
                Menu {
                    // TODO: 课表
                    Button {
                        addSchedule.toggle()
                    } label: {
                        Label("手动添加", systemImage: "plus.rectangle.on.rectangle")
                    }
                    Button {
                        vm.freshDataByInternet()
                    } label: {
                        Label("刷新课表", systemImage: "globe.europe.africa")
                    }
                    Button {
                        appInfo.cleanUp()
                        vm.freshDataOfClass()
                    } label: {
                        Label("清除课表", systemImage: "trash")
                    }

                } label: {
                    Label("More", systemImage: "ellipsis")
                }
            }
            .popover(isPresented: $addSchedule) {
                TimeScheduleAddLectureView()
            }
            .navigationTitle("第\(Date().studyWeek)周")
        }
        .navigationViewStyle(.stack)
    }
    
    private var timeline: some View {
        LazyVStack{
            Text(" ")
                .font(.footnote)
            Text(" ")
                .padding(5)
            ForEach(0..<vm.timeline.count){ index in
                Rectangle()
                    .fill(.clear)
                    .aspectRatio(0.5, contentMode: .fill)
                    .overlay(
                        VStack{
                            Text(vm.timeline[index])
                                .font(.system(size: 16))
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                        }
                    )
            }
            Spacer()
        }
        
    }
}


//struct TimeTablePage_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeSchedulePageView(vm: TimeScheduleShow())
//    }
//}
