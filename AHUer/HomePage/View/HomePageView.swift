//
//  HomePageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct HomePageView: View {
    @ObservedObject var vm: Today
    @Binding var tagNum: Int
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
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
                    NavigationLink(destination: ScoreView()) {
                        scoreLabel(gpa: vm.gpa)
                    }
                }
                .navigationBarTitle("今天")
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
    var body: some View {
        LazyVGrid(columns: [GridItem(),GridItem(),GridItem(),GridItem(),GridItem()]){
            ForEach(0..<10){ index in
                ButtonCell()
            }
        }
        .padding()
    }
    
    
    @ViewBuilder
    func ButtonCell() -> some View {
        NavigationLink(
            destination: JobView(),
            label: {
            VStack{
                Image(systemName: "envelope.open")
                    .font(.title)
                Text("校招信息")
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
                        Button(action: {
                            showGPA.toggle()
                        }, label: {
                            Image(systemName: showGPA ? "eye" : "eye.slash")
                        })
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
