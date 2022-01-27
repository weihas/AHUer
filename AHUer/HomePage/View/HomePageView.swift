//
//  HomePageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var vm: HomePageShow
    @EnvironmentObject var appInfo: AHUAppInfo
    @State var showGPA: Bool = false
    @State var jump: Int? = 0
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    helloLabel
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 450), alignment: .top)]) {
                        lectureLabel
                        buttonsLabel
                        tipsLabel
                    }
                        .padding(.top, 10)

                }
                .groupBoxStyle(ModuleBoxStyle())
            }
            .onAppear{
                vm.freshImmediatelyLecture()
            }
            .navigationTitle("今天")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationViewStyle(.automatic)
    }
    
    
    private var helloLabel: some View {
        VStack(alignment: .leading){
            Text("E01814133👋")
                .foregroundColor(.gray)
                .padding(.horizontal)
            Text("你一共有4节课")
                .font(.footnote)
                .foregroundColor(.green)
                .padding(.horizontal)
        }
    }
    
    private var lectureLabel: some View {
        GroupBox {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
                    .aspectRatio(2, contentMode: .fit)
                    .shadow(radius: 10)
                    .overlay(
                        VStack(alignment: .leading, spacing: 10){
                            HStack {
                                Text("\(vm.nextCourse?.name ?? " 高等数学 " )")
                                    .font(.title2)
                                    .fontWeight(.medium)
                               
                                Spacer()
                                Button {
                                    appInfo.tabItemNum = 1
                                } label: {
                                    Image(systemName: "ellipsis")
                                }
                            }
                            .foregroundColor(.white)
                            
                            //TODO: ProgressView
                            ProgressView(value: 11.0/18.0)
                                .foregroundColor(.orange)
                            Group{
                                Label(StartTime(rawValue: Int(vm.nextCourse?.startTime ?? 0))?.des ?? " 8:00-10:00 " , systemImage: "clock")
                                Label(vm.nextCourse?.teacher ?? " Cindy ", systemImage: "person")
                                Label(vm.nextCourse?.location ?? " 博学南楼 " , systemImage: "location")
                            }
                            .font(.footnote)
                            .foregroundColor(.white)
                        }
                            .padding()
                    )
        } label: {
            Label("即将开始", systemImage: "bolt")
        }
        .padding([.horizontal,.bottom])
    }
    
    private var buttonsLabel: some View {
        VStack{
            GroupBox {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)]){
                    ForEach(vm.buttonsInfo, id: \.id){ b in
                        NavigationLink {
                            Group{
                                switch b.id{
                                case 0:
                                    EmptyRoomView(vm: vm.emptyClassVM)
                                case 1:
                                    ScoreView(vm: vm.scoreViewVM)
                                case 2:
                                    ExamSiteView(vm: vm.examSiteVM)
                                case 3:
                                    BathView()
                                case 4:
                                    DistributionView(vm: vm.distributionVM)
                                default:
                                    MoreView()
                                }
                            }
                        } label: {
                            ButtonCell(button: b)
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
    
    private var bathLabel: some View {
        NavigationLink(destination: BathView()) {
            GroupBox(label: Label("浴室开放", systemImage: "drop")){
                VStack(alignment: .leading){
                    Text("北区: " + (vm.NorthBathroomisMen ? "男生" : "女生"))
                    Text( "南区/蕙园: " + (vm.NorthBathroomisMen ? "女生" : "男生"))
                }
            }
            .groupBoxStyle(ColorBoxStyle(.purple))
        }
    }
    
    private var scoreLabel: some View {
        NavigationLink(destination: ScoreView(vm: vm.scoreViewVM)) {
            GroupBox(label: Label("成绩查询", systemImage: "doc.text.below.ecg")){
                VStack(alignment: .leading){
                    Text("学期绩点: " + (showGPA ? "\(vm.gpa.0)" : "*. **"))
                    Text("全程绩点: " + (showGPA ? "\(vm.gpa.1)" : "*. **"))
                }
            }
            .overlay(
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            showGPA.toggle()
                        } label: {
                            Image(systemName: showGPA ? "eye" : "eye.slash")
                                .foregroundColor(Color(.systemBackground))
                        }
                        .padding([.trailing,.top], 20)
                    }
                    Spacer()
                }
            )
            .groupBoxStyle(ColorBoxStyle(.orange))
        }
    }
    
    private var examLabel: some View {
        NavigationLink(destination: ExamSiteView(vm: ExamSiteShow())) {
            GroupBox(label: Label("考试日程", systemImage: "doc.text.below.ecg")){
                VStack(alignment: .leading){
                    Text("学期绩点: " + (showGPA ? "\(vm.gpa.0)" : "*. **"))
                    Text("全程绩点: " + (showGPA ? "\(vm.gpa.1)" : "*. **"))
                }
            }
            .groupBoxStyle(ColorBoxStyle(.green))
        }
    }
    
    
}




private struct ButtonCell: View {
    @State var showSheet: Bool = false
    var button: ButtonInfo
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(button.color)
            .shadow(color: .secondary, radius: 3, x: 1, y: 1)
            .opacity(0.8)
            .overlay(
                HStack{
                    Spacer()
                    Image(systemName: button.icon)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                    Text(button.name)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .lineLimit(1)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            )
    }
}



struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(vm: HomePageShow())
            .previewDevice("iPhone 13 mini")
            .environmentObject(AHUAppInfo())
        HomePageView(vm: HomePageShow())
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .environmentObject(AHUAppInfo())
    }
}

