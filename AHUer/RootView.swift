//
//  RootView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI


/// 根视图TabView
struct RootView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    private var rootVM = RootViewShow()
    
    var body: some View {
        TabView(selection: $appInfo.tabItemNum) {
            ForEach(TabPage.allCases) { page in
                creatView(tabPage: page)
                    .tabItem {
                        Label(page.name, systemImage: page.icon)
                    }
                    .tag(page)
                    
            }
            
        }
        .navigationViewStyle(.stack)
        .font(.headline)
        .onAppear {
            appInfo.freshLogginStatus()
        }
    }
    
    
    
    @ViewBuilder
    func creatView(tabPage: TabPage) -> some View {
        NavigationView {
            Group {
                switch tabPage {
                case .homePage:
                    HomePageView(vm: rootVM.HomePageViewModel)
                case .schedulePage:
                    ScheduleView(vm: rootVM.timeScheduleViewModel)
                case .personal:
                    PersonalPageView(vm: rootVM.PersonalPageViewModel)
                }
            }
            .navigationTitle(tabPage.title)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(AHUAppInfo())
    }
}
