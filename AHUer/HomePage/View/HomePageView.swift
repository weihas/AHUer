//
//  HomePageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var vm: Today
    @State var showGPA: Bool = false
    @Binding var tagNum: Int
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ScrollViewReader { proxy in
                    ScrollView{
                        
                        LectureLabel(lectures: vm.todayLectures)
                            .onTapGesture {
                                tagNum = 1
                            }
                        ButtonsLabel()
                        Spacer()
                        NavigationLink(destination: BathView()) {
                            bathLabel(southisMan: vm.southBathroomisMen)
                        }
                        
                        ZStack {
                            NavigationLink(destination: ScoreView()) {
                                scoreLabel(gpa: vm.gpa)
                            }
                            VStack {
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        withAnimation(){
                                            showGPA.toggle()
                                        }
                                    }, label: {
                                        Image(systemName: showGPA ? "eye" : "eye.slash")
                                    })
                                    .font(.title)
                                    .padding(30)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                }
                .navigationBarTitle("今天")
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}


struct LectureLabel: View {
    @State private var lectureName = "未导入课表或尚未选课，请导入"
    @State private var lectureLocation = "暂无数据"
    @State private var lectureTime = "0-0"
    init(lectures: [Lecture]) {
        if let lecture  = lectures.first {
            lectureName = lecture.name
            lectureLocation = lecture.location
            lectureTime = "\(lecture.startTime) - \(lecture.endTime)"
        }
    }
    
    var body: some View{
        GroupBox(label: Label("今日课程", systemImage: "note.text")) {
            Text(lectureName)
                .font(.title3)
                .foregroundColor(.blue)
            HStack{
                Label(lectureLocation, systemImage: "location")
                Label(lectureTime, systemImage: "clock")
                Spacer()
            }
            .font(.footnote)
        }
        .padding()
    }
}


struct ButtonsLabel: View {
    var titles: [String] = ["校招信息","校园电话","空闲教室","成绩查询","考场查询","共享课表","餐卡丢拾","浴室开放","垃圾分类","更多功能"]
    var icons: [String] = ["envelope.badge","phone.bubble.left.fill","filemenu.and.selection","doc.text.below.ecg","doc.text.magnifyingglass","folder.badge.person.crop","creditcard","drop","trash","ellipsis"]
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 30,maximum: 50), spacing: 30, alignment: .bottom), count: 5)){
            ForEach(0..<10){ index in
                ButtonCell(title: titles[index], icon: icons[index])
            }
        }
        .padding()
    }
    
    
    @ViewBuilder
    func ButtonCell(title: String,icon: String) -> some View {
        NavigationLink(
            destination: JobView(),
            label: {
                VStack{
                Image(systemName: icon)
                    .font(.title)
                Text(title)
                    .font(.caption)
            }
        })
    }
}




struct bathLabel: View {
    var southisMan: Bool
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .shadow(color: .gray, radius: 60, x: 0.0, y: 0.0)
            VStack(alignment: .center, spacing: 20){
                HStack{
                    Text("北区: ")
                    Text(southisMan ? "女生" : "男生")
                }
                HStack{
                    Text("南区/蕙园: ")
                    Text(southisMan ? "男生" : "女生")
                }
                
            }
            VStack{
                HStack{
                    Image(systemName: "drop")
                    Text("浴室开放")
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .aspectRatio(2, contentMode: .fill)
        .padding()
    }
}


struct scoreLabel: View {
    @State var showGPA: Bool = false
    @State var thisGradeGPA: String = "*.**"
    @State var allGradeGPA: String = "*.**"
    
    init(gpa:(Double,Double)) {
        thisGradeGPA = "\(gpa.0)"
        allGradeGPA = "\(gpa.1)"
    }
    var body: some View{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .stroke()
                    .shadow(color: .gray, radius: 60, x: 0.0, y: 0.0)
                VStack(alignment: .center, spacing: 20){
                    HStack{
                        Text("学期绩点: ")
                        Text(showGPA ? thisGradeGPA : "*.**")
                    }
                    HStack{
                        Text("全程绩点: ")
                        Text(showGPA ? allGradeGPA : "*.**")
                    }
                    
                }
                
                VStack{
                    HStack{
                        Image(systemName: "doc.text.below.ecg")
                        Text("成绩查询")
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }
            .aspectRatio(2, contentMode: .fill)
            .padding()
        }
    }


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(vm: Today(), tagNum: .constant(0))
    }
}
