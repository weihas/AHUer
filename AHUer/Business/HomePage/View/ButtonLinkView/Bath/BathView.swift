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
                cardsView
                    .padding()
            }
            .frame(maxWidth: 500)
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
            .onAppear {
                withAnimation(.spring()) {
                    show.toggle()
                }
                vm.freshModel()
            }
            .navigationTitle("浴室开放")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var cardsView: some View {
        ZStack{
            CardOfBathView(date: Date(), northisMen: vm.northisMen, isToday: true)
                .aspectRatio(1.5, contentMode: .fit)
                .padding()
                .zIndex(1)

            CardOfBathView(date: Date().adding(day: 1)!, northisMen: !vm.northisMen, isToday: false)
                .aspectRatio(1.5, contentMode: .fit)
                .padding(30)
                .zIndex(-1)
                .rotationEffect(show ? .degrees(30) : .zero)
                .offset(y: show ? 200 : 0)

            ForEach(2..<5) { index in
                CardOfBathView(date: Date().adding(day: index)!, northisMen: index%2 == 0, isToday: index%2 == 0)
                    .aspectRatio(1.5, contentMode: .fit)
                    .padding(30)
                    .zIndex(Double(-index))
                    .rotationEffect(show ? .degrees(Double.random(in: 0...300)) : .zero)
                    .offset(show ? CGSize(width: Double.random(in: -100...100), height: Double.random(in: 0...50) + 80*Double(index)) : .zero)
            }
        }
    }
}

fileprivate struct CardOfBathView: View {
    var date: Date
    var northisMen: Bool
    var isToday: Bool
    
    var todayOfweek: String {
        return (isToday ? "今日" : "明日") + "-" + "\(date.weekDayInChinese)"
    }
    
    var dateString: String {
        let year = "\(date.year)"
        let month = "-\(date.month)-"
        let day = "\(date.day)"
        return year + month + day
    }
    
    var timeScope: String = "10:30-21:00"
    
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
                            Text(todayOfweek)
                            Text(dateString)
                            Text(timeScope)
                        }
                        .padding()
                    }
                    HStack{
                        VStack{
                            Text(northisMen ? "北区" : "南区/蕙园")
                                .font(.title)
                            Text("男生")
                                .padding()
                        }
                        .padding()
                        Spacer()
                        VStack{
                            Text(northisMen ? "南区/蕙园" : "北区")
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
