//
//  SettingView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @AppStorage("showLecture") private var showLecture: Bool = false
    @AppStorage(AHUerDefaultsKey.Schedule_IsGridModel.rawValue, store: .standard) var scheduleisGridModel: Bool = false
    @AppStorage(AHUerDefaultsKey.Schedule_HideWeekend.rawValue, store: .standard) var scheduleHideWeekend: Bool = false
    @AppStorage(AHUerDefaultsKey.Schedule_ShowOtherWeek.rawValue, store: .standard) var scheduleshowOtherWeek: Bool = false
    
    var body: some View {
        Form{
            Section(header: Text("课表").font(.footnote)) {
//                Button("导入课表"){
//                    print("导入课表")
//                    //TODO: 导入课表
//                }
                NavigationLink("手动添加课表", destination: ScheduleAddLectureView())
               
            }
            Section(header: Text("界面").font(.footnote)) {
                Toggle("网格模式", isOn: $scheduleisGridModel)
                Toggle("隐藏周末", isOn: $scheduleHideWeekend)
            }
            
            Section(header: Text("显示").font(.footnote)) {
                Toggle(isOn: $scheduleshowOtherWeek) {
                    Text("显示非本周课表")
                }
                Toggle(isOn: $showLecture) {
                    Text("显示讲座信息")
                }
            }
            Section(header: Text("其他").font(.footnote)) {
                Button("清除缓存"){
                    cleanUp()
                }
                .foregroundColor(.blue)
            }
            
        }
        .navigationBarTitle("设置")
    }
    
    func cleanUp(){
        Student.cleanUp()
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
