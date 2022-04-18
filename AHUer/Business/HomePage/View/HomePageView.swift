//
//  HomePageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: HomePageShow
    @State var showGPA: Bool = false
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    helloLabel
                        .onTapGesture {
                            appInfo.tabItemNum = 3
                        }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 450), alignment: .top)]) {
                        NextLectureLabel(
                            courseName: vm.nextCourseName,
                            courseProgress: vm.nextCourseProgress,
                            startTime: vm.nextCourseStartTime,
                            teacher: vm.nextCourseTeacher,
                            location: vm.nextCourseLocation
                        )
                        buttonsLabel
                        tipsLabel
                    }
                    .padding(.top, 10)
                    
                }
                .groupBoxStyle(ModuleBoxStyle())
            }
            .onAppear{
                vm.freshModels()
            }
            .navigationTitle("今天")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationViewStyle(.stack)
    }
    
    
    private var helloLabel: some View {
        VStack(alignment: .leading){
            Text(vm.welcomeTitle)
                .foregroundColor(.gray)
                .padding(.horizontal)
            if let subtitle = vm.welcomeSubtitle {
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.green)
                    .padding(.horizontal)
            }
        }
    }
    
    private var buttonsLabel: some View {
        VStack{
            GroupBox {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)]){
                    ForEach(vm.homeButtons){ btn in
                        NavigationLink {
                           distinationView(style: btn)
                        } label: {
                            ButtonCell(button: btn)
                                .frame(height: 40)
                        }
                    }
                }
            } label: {
                Label("Func", systemImage: "lightbulb")
            }
        }
        .padding([.horizontal,.bottom])
    }
    
    @ViewBuilder
    private func distinationView(style: HomePageFunc)  -> some View {
        switch style {
        case .emptyRoom :
            EmptyRoomView(vm: vm.emptyClassVM)
        case .scoreSearch:
            ScoreView(vm: vm.scoreViewVM)
        case .examSearh:
            ExamSiteView(vm: vm.examSiteVM)
        case .bathroom:
            BathView(vm: vm.bathInfoVM)
        case .distribution:
            DistributionView(vm: vm.distributionVM)
        default:
            MoreView()
        }
    }
    
    private var tipsLabel: some View{
        GroupBox {
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    bathLabel
                    scoreLabel
                    examLabel
                }
            }
        } label: {
            Label("Tips", systemImage: "bookmark")
                .padding(.horizontal)
        }
    }
    
    
}

extension HomePageView {
    
    private var bathLabel: some View {
        NavigationLink(destination: BathView(vm: vm.bathInfoVM)) {
            GroupBox(label: Label("浴室开放", systemImage: "drop")){
                VStack(alignment: .leading){
                    Text("北区: " + (vm.northBathisMen ? "男生" : "女生"))
                    Text( "南区/蕙园: " + (vm.northBathisMen ? "女生" : "男生"))
                }
            }
            .groupBoxStyle(ColorBoxStyle(.purple))
        }
    }
    
    private var scoreLabel: some View {
        NavigationLink(destination: ScoreView(vm: vm.scoreViewVM)) {
            GroupBox(label: Label("成绩查询", systemImage: "doc.text.below.ecg")){
                VStack(alignment: .leading){
                    Text("学期绩点: " + (showGPA ? vm.gpa.term : "*. **"))
                    Text("全程绩点: " + (showGPA ? vm.gpa.global : "*. **"))
                }
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    showGPA.toggle()
                } label: {
                    Image(systemName: showGPA ? "eye" : "eye.slash")
                        .foregroundColor(Color(.systemBackground))
                }
                .padding(20)
            }
            .groupBoxStyle(ColorBoxStyle(.orange))
        }
    }
    
    private var examLabel: some View {
        NavigationLink(destination: ExamSiteView(vm: vm.examSiteVM)) {
            GroupBox(label: Label("考试日程", systemImage: "doc.text.below.ecg")){
                VStack(alignment: .leading){
                    Text(vm.examInfo.title)
                    Text(vm.examInfo.subtitle)
                }
            }
            .groupBoxStyle(ColorBoxStyle(.green))
        }
    }
    
    
}


fileprivate struct ButtonCell: View {
    @State var showSheet: Bool = false
    var button: HomePageFunc
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(button.color)
            .shadow(radius: 2, x: 1, y: 1)
            .opacity(0.8)
            .overlay(
                HStack{
                    Spacer()
                    Image(systemName: button.funcIcon)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                    Text(button.funcName)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .lineLimit(1)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            )
    }
}


//struct HomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageView(vm: HomePageShow())
//            .previewDevice("iPhone 13 mini")
//            .environmentObject(AHUAppInfo())
//        HomePageView(vm: HomePageShow())
//            .previewDevice("iPad Pro (11-inch) (3rd generation)")
//            .environmentObject(AHUAppInfo())
//    }
//}

