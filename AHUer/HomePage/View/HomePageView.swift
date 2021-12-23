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
                buttonsLabel
                lectureLabel
                bathLabel
                scoreLabel
            }
            .onAppear{
                vm.freshImmediatelyLecture()
            }
            .navigationTitle(Text("今天"))
            .navigationBarTitleDisplayMode(.automatic)
        }
        .navigationViewStyle(.stack)
    }
    
    private var buttonsLabel: some View {
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
        .padding()
    }
    private var lectureLabel: some View {
                GroupBox(label: Label("即将开始", systemImage: "bolt.fill")){
                    Text(vm.nextCourse?.name ?? " -- " )
                        .font(.title2)
                        .foregroundColor(.blue)
                    HStack{
                        Label(vm.nextCourse?.location ?? " -- " , systemImage: "location")
                        Label(StartTime(rawValue: Int(vm.nextCourse?.startTime ?? 0))?.des ?? " -- " , systemImage: "clock")
                        Spacer()
                    }
                    .font(.footnote)
                    Divider()
                }
                .groupBoxStyle(ShortBoxStyle(backgroundColor: .orange,opacityRate: 0.8))
                .padding(.horizontal)
                .shadow(radius: 10)
                .onTapGesture {
                    appInfo.tabItemNum = 1
                }
        VStack{
            HStack{
              
                Spacer()
            }
            

            
        }

    }
    
    private var bathLabel: some View {
        NavigationLink(destination: BathView()) {
            GroupBox(label: Label("浴室开放", systemImage: "drop")){
                Text("北区: " + (vm.NorthBathroomisMen ? "男生" : "女生"))
                Text( "南区/蕙园: " + (vm.NorthBathroomisMen ? "女生" : "男生"))
            }
            .padding()
            .groupBoxStyle(ColorBoxStyle(backgroundColor: .blue))
        }
    }
    
    private var scoreLabel: some View {
        ZStack {
            NavigationLink(destination: ScoreView(vm: vm.scoreViewVM)) {
                GroupBox(label: Label("成绩查询", systemImage: "doc.text.below.ecg")){
                    Text("学期绩点: " + (showGPA ? "\(vm.gpa.0)" : "*. **"))
                    Text("全程绩点: " + (showGPA ? "\(vm.gpa.1)" : "*. **"))
                }
                .padding()
                .groupBoxStyle(ColorBoxStyle(backgroundColor: .pink))
            }
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(){
                            showGPA.toggle()
                        }
                    }, label: {
                        Image(systemName: showGPA ? "eye" : "eye.slash")
                    })
                }
                Spacer()
            }
            .foregroundColor(Color(.systemBackground))
            .font(.title2)
            .padding(30)
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



//struct HomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageView().environmentObject(AHUAppInfo())
//    }
//}

