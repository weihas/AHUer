//
//  HomePageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct HomePageView: View {
    @State var showGPA: Bool = false
    @EnvironmentObject var AppInfoData: AHUAppInfo
    let vmOfButtons = HomePageButtonsInfo()
    var body: some View {
        NavigationView{
            ScrollView{
                ButtonsLabel(vm: vmOfButtons)
                LectureLabel().environmentObject(AppInfoData)
                BathLabel().environmentObject(AppInfoData)
                ScoreLabel().environmentObject(AppInfoData)
            }
            .navigationBarTitle("今天")
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct LectureLabel: View {
    @EnvironmentObject var AppInfoData: AHUAppInfo
    @State var orderIndex: Int = 0
    
    var body: some View{
        GroupBox(label: Label("即将开始", systemImage: "note.text")) {
            Text(AppInfoData.firstlectureName)
                .font(.title2)
                .foregroundColor(.blue)
            HStack{
                Label(AppInfoData.firstlectureLocation, systemImage: "location")
                Label(AppInfoData.firstlectureTime, systemImage: "clock")
                Spacer()
            }
            .font(.footnote)
            Divider()
        }
        .groupBoxStyle(ShortBoxStyle(backgroundColor: .orange,opacityRate: 0.8))
        .padding(.horizontal)
        .shadow(radius: 10)
        .onTapGesture {
            AppInfoData.tabItemNum = 1
        }
    }
}


struct ButtonsLabel: View {
    @ObservedObject var vm: HomePageButtonsInfo
    @State var presentLink: Bool = false
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(50), spacing: 20, alignment: .bottom), count: 5)){
            ForEach(vm.buttons, id: \.id){ b in
                ButtonCell(button: b)
                    .padding(.vertical, 10)
            }
        }
        .padding()
    }
}

struct JumpView: View {
    var numOfButton: Int = 0
    var body: some View{
        switch numOfButton {
        case 0 :
            JobView()
        case 1:
            AddressBookView(vm: AddressBookLogic())
        case 2:
            EmptyClassView()
        case 3:
            ScoreView()
        case 4:
            ExamSiteView()
        case 5:
            ShareTableView()
        case 6:
            SearchView()
        case 7:
            BathView()
        case 8:
            TrashClassifyView()
        default:
            MoreView()
        }
    }
}



struct ButtonCell: View {
    @State var showSheet: Bool = false
    var button: buttonData
    var body: some View {
        HomeButtonCover(icon: button.icon, color: button.color, title: button.title)
            .sheet(isPresented: $showSheet){
                JumpView(numOfButton: button.id)
            }
            .onTapGesture {
                showSheet.toggle()
            }
    }
}

struct BathLabel: View {
    @EnvironmentObject var AppInfoData: AHUAppInfo
    var body: some View{
        NavigationLink(destination: BathView()) {
            GroupBox(label: Label("浴室开放", systemImage: "drop")){
                Text("北区: " + (AppInfoData.southBathroomisMen ? "女生" : "男生"))
                Text( "南区/蕙园: " + (AppInfoData.southBathroomisMen ? "男生" : "女生"))
            }
            .padding()
            .groupBoxStyle(ColorBoxStyle(backgroundColor: .blue))
        }
    }
}


struct ScoreLabel: View {
    @State var showGPA: Bool = false
    @EnvironmentObject var AppInfoData: AHUAppInfo
    var body: some View {
        ZStack {
            NavigationLink(destination: ScoreView()) {
                GroupBox(label: Label("成绩查询", systemImage: "doc.text.below.ecg")){
                    Text("学期绩点: " + (showGPA ? "\(AppInfoData.gpa.0)" : "*. **"))
                    Text("全程绩点: " + (showGPA ? "\(AppInfoData.gpa.1)" : "*. **"))
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




struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView().environmentObject(AHUAppInfo())
    }
}

struct HomeButtonCover: View {
    let icon: String
    let color: Color
    let title: String
    var body: some View {
        VStack{
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            Spacer()
            Text(title)
                .font(.caption)
        }
    }
}

