//
//  SettingView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct SettingView: View {
    @State var showOtherWeekLectures: Bool = false
    @State var showCourse: Bool = false
    var body: some View {
        Form{
            Section(header: Text("课表").font(.footnote)) {
                Button("导入课表"){
                    print("导入课表")
                    //TODO: 导入课表
                }
                NavigationLink("手动添加课表", destination: Text("hello") )
            }
            Section(header: Text("皮肤").font(.footnote)) {
                Text("更换皮肤")
                Text("自定义皮肤")
            }
            Section(header: Text("显示").font(.footnote)) {
                Toggle(isOn: $showOtherWeekLectures) {
                    Text("显示非本周课表")
                }
                Toggle(isOn: $showCourse) {
                    Text("显示讲座信息")
                }
            }
            Section(header: Text("其他").font(.footnote)) {
                Button("清除缓存"){
                    print("清除缓存")
                }
                .foregroundColor(.blue)
            }
            
        }
        .navigationBarTitle("设置")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
