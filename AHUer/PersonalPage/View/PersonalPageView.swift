//
//  PersonalPageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI


/// 个人操作界面
struct PersonalPageView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: PersonalPageShow
    @State private var showLoggingChoose: Bool = false

    @State var isBachelor: Bool = true
    var body: some View {
        NavigationView{
            Form{
                accountSection
                operationSection
            }
            .actionSheet(isPresented: $showLoggingChoose) {
                actionSheet
            }
            .sheet(isPresented: $vm.showLoggingPanel) {
                LogginPanelView(vm: vm)
            }
            .navigationBarTitle("个人")
        }

        .navigationViewStyle(.stack)
    }
}

//MARK: 列表的Section
extension PersonalPageView{
    private var accountSection: some View{
        Section(header:  Label("账号", systemImage: "person") ,
                footer: Text(appInfo.isLoggin ? "退出教务系统认证" : "教务系统登录认证以使用课表等功能")
                    .font(.footnote)
                    .padding(.horizontal)){
            Button(action: {
                if appInfo.isLoggin{
                    showLoggingChoose.toggle()
                }else{
                    vm.showLoggingPanel.toggle()
                }
            }, label: {
                Text(appInfo.isLoggin ? vm.nowUser.name : "登录" )
                    .foregroundColor(.blue)
            })
        }
    }
    
    var distance: CGFloat{
        10
    }
    
    private var operationSection: some View{
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


//MARK: Sheet
extension PersonalPageView{
    private var actionSheet: ActionSheet {
        if appInfo.isLoggin {
            return ActionSheet(
                title: Text("是否退出登录"),
                buttons: [
                    .destructive(Text("退出")){
                        appInfo.isLoggin = false
                        Task{
                            do {
                                try await vm.logout(type: 1)
                            } catch {
                                appInfo.showAlert(with: error)
                            }
                        }
                    },
                    .cancel(Text("取消"))
                ])
        }else{
            return ActionSheet(
                title: Text("通过现有学号登录或使用其他学号"),
                buttons: [
//                    .default(Text("E01814133"),
//                             action: logginWithExist),
                    .default(Text("使用其他学号"), action: {vm.showLoggingPanel.toggle()}),
                    .cancel(Text("取消"))
                ])
        }
    }
}



//struct PersonalPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//
//        }
////        PersonalPageView(vm: PersonalPageShow(context: NSManagedObjectContext()))
//    }
//}
