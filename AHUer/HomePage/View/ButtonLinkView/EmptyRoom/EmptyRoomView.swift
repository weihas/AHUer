//
//  EmptyRoomView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import SwiftUI

struct EmptyRoomView: View{
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: EmptyRoomShow
    @State private var campus: Campus = .Qinyuan
    @State private var weekNum: Int = 10
    @State private var weekDay: Weekday = Weekday(rawValue: Date().weekDay) ?? .Mon
    @State private var time: LectureTime = .first
    @State private var weekNumChoose: Bool = false
    @State private var weekDayChoose: Bool = false
    @State private var timeChoose: Bool = false
    @State private var date = Date()
   
    
    var body: some View {
        VStack{
            Picker("校区选择", selection: $campus){
                Text("磬苑校区").tag(Campus.Qinyuan)
                Text("龙河校区").tag(Campus.LongHe)
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            
            searchMessgePicker
            
            searchResultList
            
            Spacer()
        }
        .toolbar{
            Button {
                vm.search(campus: campus.rawValue, weekday: weekDay.rawValue, weekNum: weekNum, time: time.rawValue){ status, title, description in
                    appInfo.showAlert(title: title, message: description)
                }
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
        .navigationTitle("空教室查询")
        .navigationBarTitleDisplayMode(.inline)
    }
    

    
}

//SearchMessgePicker
extension EmptyRoomView{
    private var searchMessgePicker: some View{
        VStack{
            HStack{
                Text("第 \(weekNum) 周")
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 7).fill(Color(red: 0.93, green: 0.93, blue: 0.93)))
                    .foregroundColor(weekNumChoose ? .blue : .black)
                    .onTapGesture{
                        withAnimation {
                            weekNumChoose.toggle()
                            weekDayChoose = false
                            timeChoose = false
                        }
                    }
                Text(weekDay.description)
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 7).fill(Color(red: 0.93, green: 0.93, blue: 0.93)))
                    .foregroundColor(weekDayChoose ? .blue : .black)
                    .onTapGesture {
                        withAnimation{
                            weekNumChoose = false
                            weekDayChoose.toggle()
                            timeChoose = false
                        }
                    }
                
                Text(time.description)
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 7).fill(Color(red: 0.93, green: 0.93, blue: 0.93)))
                    .foregroundColor(timeChoose ? .blue : .black)
                    .onTapGesture {
                        withAnimation{
                            weekNumChoose = false
                            weekDayChoose = false
                            timeChoose.toggle()
                        }
                    }
                
            }
            if weekNumChoose{
                weekNumChooseSegment()
                    .transition(.opacity)
            }else if weekDayChoose {
                weekDayChooseSegment()
                    .transition(.opacity)
            }else if timeChoose{
                timeSegment()
                    .transition(.opacity)
            }
        }
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

//SearchResultList
extension EmptyRoomView{
    private var searchResultList: some View{
        VStack{
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
                .onTapGesture{
                    withAnimation{
                        self.weekNumChoose = false
                        self.timeChoose = false
                        self.weekDayChoose = false
                    }
                }
                .refreshable{
                    vm.search(campus: campus.rawValue, weekday: weekDay.rawValue, weekNum: weekNum, time: time.rawValue){status, title, description in
                        appInfo.showAlert(title: title, message: description)
                    }
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
        }
    }
}
