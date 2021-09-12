//
//  PersonalPageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct PersonalPageView: View {
    @EnvironmentObject var vm: AHUAppInfo
    
    var body: some View {
        NavigationView{
            OperationListView(isLoggin: $vm.isLoggin)
                .navigationBarTitle("个人")
        }
    }
}




struct OperationListView: View {
    @Binding var isLoggin: Bool
    @State var showLoggingChoose: Bool = false
    @State var showLoggingPanel: Bool = false
   
    var body: some View {
        Form{
            AccountSection(showLoggingChoose: $showLoggingChoose)
            OperationSection()
        }.actionSheet(isPresented: $showLoggingChoose) {
            ActionSheet(
                title: Text("通过现有学号登录或使用其他学号"),
                buttons: [
                    .default(Text("E01814133"),
                                 action: logginWithExist),
                    .default(Text("使用其他学号"), action: {showLoggingPanel.toggle()}),
                    .cancel()
                ])
        }
        .sheet(isPresented: $showLoggingPanel) {
            LogginView()
        }
        
        
    }
    
    func logginWithExist() {
        isLoggin = true
    }
    
    
}




struct AccountSection: View {
    @Binding var showLoggingChoose: Bool
    var body: some View {
        Section(header:  Label("账号", systemImage: "person") ,footer: Text("教务系统登录认证以使用课表等功能").font(.footnote).padding(.horizontal)){
            Button(action: {
                showLoggingChoose = true
            }, label: {
                Text("登录")
                    .foregroundColor(.blue)
            })
            
        }
    }
}

struct OperationSection: View {
    var distance: CGFloat = 10
    var body: some View {
        Section(header: Text("操作").font(.footnote),
                footer: Text("V1.0.0-beta").font(.footnote).padding()) {
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
            NavigationLink(destination: ThanksChildView()) {
                Label("开发鸣谢", systemImage: "hammer")
                    .padding(distance)
            }
        }
    }
}



struct LogginView: View {
    @State var studentId: String = ""
    @State var password: String = ""
    @State var isBachelor: Bool = true
    
    var body: some View {
        VStack{
            Picker(selection: $isBachelor, label: Text("Picker")) {
                Text("本科生").tag(true)
                Text("研究生").tag(false)
            }
            .padding(.top, 20)
            .padding(.horizontal, 100)
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
            HStack{
                Text("学号:")
                TextField("学号", text: $studentId)
            }
            .padding()
            Divider().padding(.horizontal)
            HStack{
                Text("密码:")
                SecureField("密码", text: $password)
            }
            .padding()
            Spacer()
            Button(action: {
                print("认证")
            }, label: {
                Label("认证", systemImage: "chevron.forward.square")
            })
            .buttonStyle(ColorButtonStyle(color: .blue))
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("教务认证")
    }
}




struct PersonalPageView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPageView()
    }
}
