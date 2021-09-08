//
//  RootView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomePageView(vm: Today())
                .tabItem {
                    Image(systemName: "house")
                    Text("主页")
                }
            TimeTablePageView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("课表")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("资讯")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "graduationcap")
                    Text("个人")
                }
        }
        .accentColor(.black)
        .font(.headline)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
