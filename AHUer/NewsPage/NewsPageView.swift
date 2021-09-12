//
//  NewsPageView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct NewsPageView: View {
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
                NewsCell().padding()
            }
            .navigationBarTitle("资讯")
        }
    }
}

    
    
    struct NewsCell: View {
        var body: some View {
            VStack{
                HStack{
                    Image("imageOfPublisher")
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding()
                    VStack(alignment: .leading, spacing: 5){
                        Text("互联网学院")
                            .font(.body)
                        Text("2月前 09:56")
                            .font(.caption)
                    }
                    Spacer()
                }
                Text("这是一条新闻，bsabvhibivbi哭哈不得v把话费吧好的v好安静的邻居的好不好好不好v吧好身材不好的吧是吧但是不会吧好吧沙尘暴。八点睡会吧哈不会包产到户v不好好舍不得hi阿爸v hi不会i把手到病除和圣彼得堡承担本次哈吧好吧吃吧哈斯的不和是不会i不好 hsdbhhhhjbscdhshshvhashvbhhs应聘者应符合以下条件：一）思想政治水平。热爱祖国，热爱高等教育事业，拥护中国共产党的路线、方针和政策。遵守宪法和法律，未受过任何纪律处分及刑事处罚。为人师表，品行端正，具有扎实的专业知识、较高的学术水平和教育、教学能力，掌握现代教育技术技能，能以“四有好老师”的标准严格要求自己。\n（二）身心条件。身心健康，能适应岗位工作的要求，且达到《公务员录用体检通用标准（试行）》中规定的体检合格标准。")
            }
            
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
        NewsPageView()
    }
}
