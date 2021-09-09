//
//  PersonalPageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct PersonalPageView: View {
    @State var isLoggin: Bool = false
   
    var body: some View {
        NavigationView{
            FuncListView(isLoggin: $isLoggin)
                .navigationBarTitle("个人")
        }
    }
}


struct PersonalPageView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPageView()
    }
}

struct FuncListView: View {
    @Binding var isLoggin: Bool
    var distance: CGFloat = 10
    var body: some View {
        Form{
            GroupBox(label: Label("欢迎", systemImage: "person") ) {
                Text("E01814133")
            }
            NavigationLink(destination: LogginView()) {
                Label(isLoggin ? "认证注销":"教务认证", systemImage: isLoggin ? "exclamationmark.shield":"checkmark.shield.fill")
                    .padding(distance)
            }
            NavigationLink(destination: SettingView()) {
                Label("课表设置", systemImage: "gear")
                    .padding(distance)
            }
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                Label("帮忙推广", systemImage: "square.and.arrow.up.on.square")
                    .padding(distance)
            }
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                Label("意见反馈", systemImage: "contextualmenu.and.cursorarrow")
                    .padding(distance)
            }
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                Label("关于我们", systemImage: "person.3")
                    .padding(distance)
            }
            NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                Label("开发鸣谢", systemImage: "hammer")
                    .padding(distance)
            }
            Text("V1.0.0")
                .foregroundColor(.gray)
        }
        
    }
}
