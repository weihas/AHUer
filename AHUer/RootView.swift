//
//  RootView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var infoData: AHUAppInfo
    var body: some View {
        TabView(selection: $infoData.tabItemNum) {
            HomePageView()
                .environmentObject(infoData)
                .tabItem {
                    Image(systemName: "house")
                    Text("主页")
                }
                .tag(0)
            TimeTablePageView()
                .environmentObject(infoData)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("课表")
                }
                .tag(1)
            NewsPageView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("资讯")
                }
                .tag(2)
            PersonalPageView()
                .environmentObject(infoData)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("个人")
                }
                .tag(3)
        }
        .accentColor(Color("AccentColor"))
        .font(.headline)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
