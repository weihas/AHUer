//
//  BathView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct BathView: View {
    @ObservedObject var vm: BathOpenShow
    var body: some View {
        VStack{
            ScrollView{
                    CardOfBathView(date: Date(), southIsMen: vm.northisMan, isToday: true)
                        .aspectRatio(1.5, contentMode: .fill)
                        .padding()
                    CardOfBathView(date: Date().tomorrowDate!, southIsMen: !vm.northisMan, isToday: false)
                        .aspectRatio(1.5, contentMode: .fit)
                        .padding(30)
            }
            .onAppear{
                vm.freshLocal()
            }
            .refreshable {
                vm.freshBathroom()
            }
            .navigationTitle("浴室开放")
            .navigationBarTitleDisplayMode(.inline)
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
        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
            .foregroundColor(isToday ? .green : .pink )
            .opacity(0.6)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
            .overlay {
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
                            Text("男生")
                                .padding()
                        }
                        .padding()
                        Spacer()
                        VStack{
                            Text(southIsMen ? "北区" : "南区/蕙园")
                                .font(.title)
                            Text("女生")
                                .padding()
                        }
                        .padding()
                    }
                }
            }
    }
}


struct BathView_Previews: PreviewProvider {
    static var previews: some View {
        BathView(vm: BathOpenShow())
    }
}
