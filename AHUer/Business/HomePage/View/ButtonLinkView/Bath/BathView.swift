//
//  BathView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI

struct BathView: View {
    @ObservedObject var vm: BathOpenShow
    @State var show: Bool = false
    var body: some View {
        VStack{
            ScrollView{
                ZStack{
                    CardOfBathView(date: Date(), southIsMen: vm.northisMan, isToday: true)
                        .aspectRatio(1.5, contentMode: .fit)
                        .padding()
                        .zIndex(1)
                    
                    CardOfBathView(date: Date().adding(day: 1)!, southIsMen: !vm.northisMan, isToday: false)
                        .aspectRatio(1.5, contentMode: .fit)
                        .padding(30)
                        .zIndex(-1)
                        .rotationEffect(show ? .degrees(30) : .zero)
                        .offset(y: show ? 200 : 0)
                    
                    ForEach(2..<5) { index in
                        CardOfBathView(date: Date().adding(day: index)!, southIsMen: index%2 == 0, isToday: index%2 == 0)
                            .aspectRatio(1.5, contentMode: .fit)
                            .padding(30)
                            .zIndex(Double(-index))
                            .rotationEffect(show ? .degrees(Double.random(in: 0...300)) : .zero)
                            .offset(show ? CGSize(width: Double.random(in: -100...100), height: Double.random(in: 0...50) + 80*Double(index)) : .zero)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        withAnimation {
                            show = false
                        }
                        vm.freshBathroom()
                    } label: {
                        Label("刷新", systemImage: "arrow.clockwise")
                    }

                }
            }
            .onAppear{
                withAnimation(.spring()) {
                    show.toggle()
                }
                vm.freshLocal()
            }
            .navigationTitle("浴室开放")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

fileprivate struct CardOfBathView: View {
    var todayOfWeek: String
    var dateString: String
    var timeScope: String = "10:30-21:00"
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
//            .opacity(0.6)
            .shadow(radius: 8)
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
                .foregroundColor(.white)
            }
    }
}


//struct BathView_Previews: PreviewProvider {
//    static var previews: some View {
//        BathView(vm: BathOpenShow())
//    }
//}
