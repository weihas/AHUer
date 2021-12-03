//
//  RootView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI
import CoreData


/// 根视图TabView
struct RootView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @Environment(\.managedObjectContext) private var viewContext
    private var rootVM = RootViewShow()
    
    var body: some View {
        TabView(selection: $appInfo.tabItemNum) {
            HomePageView(vm: rootVM.HomePageViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("主页")
                }
                .tag(0)
            TimeSchedulePageView(vm: rootVM.timeScheduleViewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("课表")
                }
                .tag(1)
//            NewsPageView(newsVM: NewsPlaying())
//                .tabItem {
//                    Image(systemName: "newspaper")
//                    Text("资讯")
//                }
//                .tag(2)

            PersonalPageView(vm: rootVM.PersonalPageViewModel)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("个人")
                }
                .tag(3)
        }
        .font(.headline)
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
