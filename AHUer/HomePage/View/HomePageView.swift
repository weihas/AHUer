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
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    Text("E01814133👋")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    Text("你一共有4节课")
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(.horizontal)
                    lectureLabel
                    buttonsLabel
                        .padding(.top, 10)
                    tipsLabel
                }
            }
            .onAppear{
                vm.freshImmediatelyLecture()
            }
            .navigationTitle("今天")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationViewStyle(.stack)
    }
    
    private var buttonsLabel: some View {
        VStack(alignment: .leading){
            Label("Func", systemImage: "lightbulb")
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 120), spacing: 10, alignment: .center), count: 3)){
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
        }
        .padding(.horizontal)
    }
    
    private var tipsLabel: some View{
        VStack(alignment: .leading, spacing: 10){
            Label("Tips", systemImage: "bookmark")
                .padding([.top, .leading, .trailing])
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    bathLabel
                    scoreLabel
                    examLabel
                }
            }
        }
    }
    
    private var lectureLabel: some View {
        VStack(alignment: .leading, spacing: 10){
            Label("即将开始", systemImage: "bolt")
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
        }
        .frame(maxWidth: 340, maxHeight: 300)
        .padding(.horizontal)
    }
    
    private var bathLabel: some View {
        NavigationLink(destination: BathView()) {
            GroupBox(label: Label("浴室开放", systemImage: "drop")){
                VStack(alignment: .leading){
                    Text("北区: " + (vm.NorthBathroomisMen ? "男生" : "女生"))
                    Text( "南区/蕙园: " + (vm.NorthBathroomisMen ? "女生" : "男生"))
                }
            }
            .padding()
            .groupBoxStyle(ColorBoxStyle(backgroundColor: .purple))
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
                        Button(action: {
                            showGPA.toggle()
                        }, label: {
                            Image(systemName: showGPA ? "eye" : "eye.slash")
                        })
                            .padding([.trailing,.top], 5)
                    }
                    Spacer()
                }
            )
            .padding()
            .groupBoxStyle(ColorBoxStyle(backgroundColor: .orange))
        }
        .foregroundColor(Color(.systemBackground))
    }
    
    private var examLabel: some View {
        NavigationLink(destination: ExamSiteView(vm: ExamSiteShow())) {
            GroupBox(label: Label("考试日程", systemImage: "doc.text.below.ecg")){
                VStack(alignment: .leading){
                    Text("学期绩点: " + (showGPA ? "\(vm.gpa.0)" : "*. **"))
                    Text("全程绩点: " + (showGPA ? "\(vm.gpa.1)" : "*. **"))
                }
            }
            .padding()
            .groupBoxStyle(ColorBoxStyle(backgroundColor: .green))
        }
        .foregroundColor(Color(.systemBackground))
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
            .environmentObject(AHUAppInfo())
    }
}

