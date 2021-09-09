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
            Section(header: Text("欢迎").font(.footnote)) {
                Label("E01814133 whw", systemImage: "person")
                    .padding()
            }
            Section(header: Text("操作").font(.footnote),
                    footer: Text("V1.0.0beta").font(.footnote).padding()) {
                NavigationLink(destination: LogginView()) {
                    Label(isLoggin ? "认证注销":"教务认证", systemImage: isLoggin ? "checkmark.shield.fill":"exclamationmark.shield")
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
            }
        }
        
    }
}
