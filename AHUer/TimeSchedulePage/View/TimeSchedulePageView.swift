//
//  TimeTablePage.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

struct TimeSchedulePageView: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @ObservedObject var vm: TimeScheduleShow
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var numOfWeek: Int = 10
   
    var body: some View {
        NavigationView{
            ScrollView{
                HStack(alignment: .top){
                    timeline
                        .padding(.horizontal,5)
                    ForEach(vm.timetableInfos){ info in
                        ClassInOneDayView(model: info)
                    }
                }
            }
            .onAppear{
                vm.freshDataOfClass(context: viewContext, predicate: appInfo.whoAmIPredicate)
            }
            .toolbar{
                Button {
                    print("something")
                } label: {
                    Label("More", systemImage: "ellipsis")
                }
            }
            .navigationTitle("第\(numOfWeek)周")
        }
        .navigationViewStyle(.stack)
    }
    
    private var timeline: some View {
        LazyVStack{
            Text(" ")
                .font(.footnote)
            Text(" ")
                .padding(5)
            ForEach(0..<vm.timeline.count){ index in
                Text(vm.timeline[index])
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(height: 100, alignment: .top)
            }
            Spacer()
        }
        
    }
}

struct ClassInOneDayView: View {
    var model: ClassInOneDay
    var isToday: Bool {
        get { Date().weekDay == model.id }
    }
    
    var data: Int{
        get { Date().day + (model.id - Date().weekDay) }
    }
    
    var body: some View{
        LazyVStack{
            titleOfToday
            ForEach(model.schedule){ lecture in
                LectureViewCell(lecture: lecture)
                    .frame(height: 100, alignment: .top)
                    .contextMenu
                    {
                        Text(lecture.name)
                        Text(lecture.location)
                    }
            }
            Spacer()
        }
    }
    
    private var titleOfToday: some View {
        LazyVStack{
            Text(model.weekDay)
                .font(.footnote)
            Text(isToday ?  "今" : "\(data)")
                .padding(5)
                .background(Circle().fill(isToday ? Color.gray : Color.clear))
        }
    }
}

struct LectureViewCell: View{
    var lecture: TableClassCellModel
    var body: some View {
        GeometryReader{ geometry in
            RoundedRectangle(cornerRadius: 5)
                .fill(lecture.isShow ? lecture.color : .clear)
                .frame(width: geometry.size.width, height: lecture.lectureLengthIsTwo ? geometry.size.height : geometry.size.height/2)
                .overlay(
                    VStack{
                        Text(lecture.name)
                            .font(.system(size: 16))
                            .minimumScaleFactor(0.8)
                        Text(lecture.lectureLengthIsTwo ? lecture.location : "...")
                            .font(.system(size: 13))
                            .minimumScaleFactor(0.5)
                    }
                        .foregroundColor(.white)
                )
        }
    }
}


//
//struct weekdayCell: View {
//    var indexOfThisWeek: Int
//    var weekday: String
//    var todayDate: String
//    private var isToday: Bool = false
//
//    init(_ indexOfThisWeek: Int , _ today: Date) {
//        self.indexOfThisWeek = indexOfThisWeek
//        if let day = today.adding(day: indexOfThisWeek - today.weekDay + 2 ){
//            self.todayDate = "\(day.month)/\(day.day)"
//            self.isToday = day.isToday()
//        }else{
//            self.todayDate = "9/1"
//        }
//        switch indexOfThisWeek {
//        case 0:
//            weekday = "一"
//        case 1:
//            weekday = "二"
//        case 2:
//            weekday = "三"
//        case 3:
//            weekday = "四"
//        case 4:
//            weekday = "五"
//        case 5:
//            weekday = "六"
//        default:
//            weekday = "日"
//        }
//    }
//
//
//    var body: some View {
//        VStack{
//            Text(weekday)
//            ZStack{
//                RoundedRectangle(cornerRadius: 5)
//                    .foregroundColor(isToday ? .blue : .white )
//                    .frame(width: 20, height: 20, alignment:.center)
//                Text(isToday ? "今" : todayDate)
//                    .font(.footnote)
//                    .foregroundColor(isToday ? .white : .gray)
//            }
//        }
//    }
//}
//
//struct timeLineView: View {
//    @ObservedObject var vm: TimeScheduleShow
//
//    var body: some View {
//        ScrollView{
//            ForEach(vm.timetableInfos.indices){ rowIndex in
//                if rowIndex == 4 || rowIndex == 8{
//                    Divider()
//                }
//                HStack(alignment:.top){
//                    Text(vm.timeline[rowIndex])
//                        .font(.footnote)
//                    ForEach(vm.timetableInfos[rowIndex]){ info in
//                        TableClassCell(tablecellModel: info)
//                    }
//                }
//            }
//        }
//    }
//}

//struct TimeTablePage_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeSchedulePageView(vm: TimeTableShow(context: <#NSManagedObjectContext#>))
//    }
//}
