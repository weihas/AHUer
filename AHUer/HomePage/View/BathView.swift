//
//  BathView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct BathView: View {
    @State var southIsMen: Bool = false
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    CardOfBathView(date: Date(), southIsMen: southIsMen, isToday: true)
                        .aspectRatio(1.5, contentMode: .fill)
                        .padding()
                    CardOfBathView(date: Date().tomorrowDate!, southIsMen: !southIsMen, isToday: false)
                        .aspectRatio(1.5, contentMode: .fit)
                        .padding(30)
                    
                }
            }
            .navigationBarTitle("浴室开放",displayMode: .inline)
        }
    }
}

fileprivate struct CardOfBathView: View {
    var todayOfWeek: String
    var dateString: String
    var timeScope: String =  "10:30-21:00"
    var southIsMen: Bool
    var isToday: Bool
    
    init(date: Date,southIsMen: Bool, isToday: Bool) {
        self.todayOfWeek = "\(isToday ? "今日" : "明日")-\(date.weekDayInChinese)"
        self.dateString = "\(date.year)-\(date.month)-\(date.day)"
        self.southIsMen = southIsMen
        self.isToday = isToday
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .foregroundColor(isToday ? .green : .pink )
                .opacity(0.5)
            VStack{
                HStack{
                    Spacer()
                    VStack(alignment: .trailing, spacing: nil){
                        Text(todayOfWeek)
                        Text(dateString)
                        Text(timeScope)
                    }
                    .padding()
                }
                HStack{
                    VStack{
                        Text(southIsMen ? "南区/蕙园" : "北区")
                            .font(.title)
                            .padding()
                        Text("男生")
                    }
                    .padding()
                    Spacer()
                    VStack{
                        Text(southIsMen ? "北区" : "南区/蕙园")
                            .font(.title)
                            .padding()
                        Text("女生")
                    }
                    .padding()
                }
            }
        }
    }
}


struct BathView_Previews: PreviewProvider {
    static var previews: some View {
        BathView()
    }
}
