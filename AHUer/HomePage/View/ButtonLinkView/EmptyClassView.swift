//
//  EmptyClassView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct EmptyClassView: View{
    @ObservedObject var vm: EmptyClassShow
    @State private var campus: Campus = .Qinyuan
    @State private var weekNum: Int = 1
    @State private var weekDay: Weekday = Weekday(rawValue: Date().weekDay) ?? .Mon
    @State private var time: LectureTime = .first
    @State private var weekNumChoose: Bool = true
    @State private var weekDayChoose: Bool = false
    @State private var timeChoose: Bool = false
    
   
    
    var body: some View {
        VStack{
            Picker("校区选择", selection: $campus){
                Text("磬苑校区").tag(Campus.Qinyuan)
                Text("龙河校区").tag(Campus.LongHe)
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            HStack{
                Button("第 \(weekNum) 周"){
                    withAnimation{
                        weekNumChoose.toggle()
                        weekDayChoose = false
                        timeChoose = false
                    }
                }
                .foregroundColor(weekNumChoose ? .blue : .black)
                Button(weekDay.description){
                    withAnimation{
                        weekNumChoose = false
                        weekDayChoose.toggle()
                        timeChoose = false
                    }
                }
                .foregroundColor(weekDayChoose ? .blue : .black)
                Button(time.description){
                    withAnimation{
                        weekNumChoose = false
                        weekDayChoose = false
                        timeChoose.toggle()
                    }
                }
                .foregroundColor(timeChoose ? .blue : .black)
            }
            if weekNumChoose{
                weekNumChooseSegment()
            }else if weekDayChoose {
                weekDayChooseSegment()
            }else if timeChoose{
                timeSegment()
            }

            if #available(iOS 15.0, *) {
                List{
                    ForEach(vm.emptyRooms){ session in
                        Section(session.name){
                            ForEach(session.rooms){ room in
                                HStack{
                                    Text(room.pos)
                                    Spacer()
                                    Text("座位数" + room.seating)
                                }
                            }
                            
                        }
                    }
                    
                }
                .refreshable{
                    vm.search(campus: campus.rawValue, weekday: weekDay.rawValue, weekNum: weekNum, time: time.rawValue)
                }
            } else {
                List{
                    ForEach(vm.emptyRooms){ session in
                        ForEach(session.rooms){ room in
                            HStack{
                                Text(room.pos)
                                Spacer()
                                Text(room.seating)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .toolbar{
            Button {
                vm.search(campus: campus.rawValue, weekday: weekDay.rawValue, weekNum: weekNum, time: time.rawValue)
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
        .navigationTitle("空教室查询")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func weekNumChooseSegment() -> some View{
        Divider()
        Picker("周数选择", selection: $weekNum){
            ForEach(1..<19){ index in
                Text("第\(index)周").tag(index)
            }
        }
        .pickerStyle(InlinePickerStyle())
        .transition(.opacity)
    }
    @ViewBuilder
    private func weekDayChooseSegment() -> some View{
        Divider()
        Picker("周几选择", selection: $weekDay){
            ForEach(Weekday.allCases){ weeday in
                Text(weeday.description).tag(weeday)
            }
        }
        .pickerStyle(InlinePickerStyle())
        .transition(.opacity)
        
    }
    @ViewBuilder
    private func timeSegment() -> some View{
        Divider()
        Picker("时间选择", selection: $time){
            ForEach(LectureTime.allCases){ time in
                Text(time.description).tag(time)
            }
        }
        .pickerStyle(InlinePickerStyle())
        .transition(.opacity)
    }
    
}
