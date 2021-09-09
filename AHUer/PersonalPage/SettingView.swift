//
//  SettingView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List{
            Text("导入课表")
            Text("手动添加课表")
            Spacer()
            Text("更换皮肤")
            Text("自定义皮肤")
            Spacer()
            
        }
        .listStyle(InsetListStyle())
        .navigationBarTitle("设置")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
