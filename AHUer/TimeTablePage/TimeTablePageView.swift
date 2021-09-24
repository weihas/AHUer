//
//  TimeTablePage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct TimeTablePageView: View {
    @State private var numOfWeek: Int = 1
    @ObservedObject var vm: TimeTableShow
    
    var body: some View {
        ZStack{
            VStack{
                Text("第\(numOfWeek)周")
                TitleBarView()
                timeLineView(vm: vm)
            }
            .padding()
        }
    }
}

struct TitleBarView: View {
    var body: some View{
        Divider()
        HStack(spacing: 20){
            Button(action: {
                
            }, label: {
                Image(systemName:  "square.and.arrow.down.on.square")
            })
            ForEach(0..<7){ index in
                weekdayCell(index,Date())
            }
        }
        Divider()
    }
    
}

struct weekdayCell: View {
    var indexOfThisWeek: Int
    var weekday: String
    var todayDate: String
    private var isToday: Bool = false
    
    init(_ indexOfThisWeek: Int , _ today: Date) {
        self.indexOfThisWeek = indexOfThisWeek
        if let day = today.adding(day: indexOfThisWeek - today.weekDay + 2 ){
            self.todayDate = "\(day.month)/\(day.day)"
            self.isToday = day.isToday()
        }else{
            self.todayDate = "9/1"
        }
        switch indexOfThisWeek {
        case 0:
            weekday = "一"
        case 1:
            weekday = "二"
        case 2:
            weekday = "三"
        case 3:
            weekday = "四"
        case 4:
            weekday = "五"
        case 5:
            weekday = "六"
        default:
            weekday = "日"
        }
    }
    
    
    var body: some View {
        VStack{
            Text(weekday)
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(isToday ? .blue : .white )
                    .frame(width: 20, height: 20, alignment:.center)
                Text(isToday ? "今" : todayDate)
                    .font(.footnote)
                    .foregroundColor(isToday ? .white : .gray)
            }
        }
    }
}

struct timeLineView: View {
    @ObservedObject var vm: TimeTableShow
    
    var body: some View {
        ScrollView{
            ForEach(vm.timetableInfos.indices){ rowIndex in
                if rowIndex == 4 || rowIndex == 8{
                    Divider()
                }
                HStack(alignment:.top){
                    Text(vm.timeline[rowIndex])
                        .font(.footnote)
                    ForEach(vm.timetableInfos[rowIndex]){ info in
                        TableClassCell(tablecellModel: info)
                    }
                }
            }
        }
    }
}

struct TimeTablePage_Previews: PreviewProvider {
    static var previews: some View {
        TimeTablePageView(vm: TimeTableShow())
    }
}
