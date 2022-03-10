//
//  NewsPageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI
import Foundation

struct NewsPageView: View {
    @ObservedObject var newsVM: NewsPlaying
    @State var showPage: Int = 0
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Text(Date().yearMonthDay)
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    Spacer()
                }
                NewsSourcePicker(showPage: $showPage)
                ForEach(newsVM.news){ news in
                    CardUnit(Singelnews: news)
                }
            }
            .navigationTitle("资讯")
        }
    }
}




struct CardUnit: View {
    @State var isShow = false
    @State var isTab = false
    @Namespace var namespace
    var Singelnews: NewsItem
    
    
    
    var body: some View {
        ZStack{
            Card(isShow: $isShow, news: Singelnews)
                .padding()
                .matchedGeometryEffect(id: "Card", in: namespace, properties: .frame, anchor: .center, isSource: true)
                .transition(.opacity)
                .scaleEffect(isTab ? 0.9 : 1)
                .onLongPressGesture(
                    minimumDuration: 0.5,
                    maximumDistance: 4,
                    pressing: { press in
                        withAnimation{
                            isTab = press}
                    },
                    perform: {
                        withAnimation{
                            isShow = true
                        }
                    })
            
            
            if isShow {
                Card(isShow: $isShow, news: Singelnews)
                    .padding(3)
                    .zIndex(5)
                    .matchedGeometryEffect(id: "Card", in: namespace)
                    .onTapGesture {
                        withAnimation{
                            isShow = false
                        }
                    }

            }
            
        }
        
        
    }
}


struct Card: View {
    @Binding var isShow: Bool
    var news: NewsItem
    var body: some View {
        VStack(){
                Image("test")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            HStack{
                Image("imageOfPublisher")
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding()
                HStack {
                    VStack(alignment: .leading) {
                        Text(news.author)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(news.title)
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Text(news.time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                Spacer()
            }
            .padding()
            if isShow {
                Text("这是一条新闻，bsabvhibivbi哭哈不得v把话费吧好的v好安静的邻居的好不好好不好v吧好身材不好的吧是吧但是不会吧好吧沙尘暴。八点睡会吧哈不会包产到户v不好好舍不得hi阿爸v hi不会i把手到病除和圣彼得堡承担本次哈吧好吧吃吧哈斯的不和是不会i不好 hsdbhhhhjbscdhshshvhashvbhhs应聘者应符合以下条件：一）思想政治水平。热爱祖国，热爱高等教育事业，拥护中国共产党的路线、方针和政策。遵守宪法和法律，未受过任何纪律处分及刑事处罚。为人师表，品行端正，具有扎实的专业知识、较高的学术水平和教育、教学能力，掌握现代教育技术技能，能以“四有好老师”的标准严格要求自己。\n（二）身心条件。身心健康，能适应岗位工作的要求，且达到《公务员录用体检通用标准（试行）》中规定的体检合格标准。")
                    .padding()
                Spacer()
            }
        }
        .cornerRadius(25)
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
                .shadow(radius: isShow ? 3 : 10)
        )
        
    }
}










struct NewsSourcePicker: View {
    @Binding var showPage: Int
    var body: some View {
        CapsulePickStyle(selectNum: $showPage, dataSource: ["院系风采","教务通知","社团动态","校招实习"])
    }
}



struct NewsPageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView(newsVM: NewsPlaying())
//        NewsCell()
//        NewsCell()
//            .previewLayout(.fixed(width: 300, height: 400))
//            .preferredColorScheme(.dark)
    }
}
