//
//  TimeTablePage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct TimeTablePageView: View {
    @State private var numOfWeek: Int = 1
    var body: some View {
        VStack{
            Text("第\(numOfWeek)周")
            TitleBarView()
            HStack{
                timeLineView()
                Spacer()
            }
        }
        .padding()
    }
    
    
    
    
}

struct TitleBarView: View {
    var body: some View{
        Divider()
        HStack{
            Button(action: {
                
            }, label: {
                Image(systemName:  "square.and.arrow.down.on.square")
            })
            ForEach(0..<7){ index in
                Spacer()
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
    var times: [String] = ["8:20","9:15","10:20","11:15","14:00","14:55","15:50","16:45","19:00","19:55","20:50"]
    var body: some View {
        List{
            ForEach(times.indices){ index in
                VStack{
                    Text("\(index+1)")
                        .font(.callout)
                    Text(times[index])
                        .font(.footnote)
                }
            }
        }
    }
}



struct TimeTablePage_Previews: PreviewProvider {
    static var previews: some View {
        TimeTablePageView()
    }
}

//VStack{
//
//}
