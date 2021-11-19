//
//  TimeScheduleCell.swift.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/11/19.
//

import Foundation

import SwiftUI

struct ClassInOneDayView: View {
    var model: ClassInOneDay
    var isToday: Bool {
        get { Date().weekDay == model.id }
    }
    
    var data: Int{
        get { Date().day + (model.id - Date().weekDay) }
    }
    
    var body: some View{
        if model.hasLecture{
            LazyVStack{
                titleOfToday
                ForEach(model.schedule, id: \.id){ lecture in
                    LectureViewCell(lecture: lecture)
                        .aspectRatio(0.5, contentMode: .fit)
                }
                Spacer()
            }
        }else{
            
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
            Group{
                RoundedRectangle(cornerRadius: geometry.size.width * 0.1)
                    .fill(lecture.isShow ? lecture.color : .clear)
                    .frame(width: geometry.size.width, height: lecture.lectureLengthIsTwo ? geometry.size.height : geometry.size.height/2)
                    .overlay(
                        VStack{
                            Text(lecture.name)
                                .font(.system(size: 16))
                                .minimumScaleFactor(0.8)
                            Text(lecture.lectureLengthIsTwo ? lecture.location : lecture.isShow ? "..." : "")
                                .font(.system(size: 13))
                                .minimumScaleFactor(0.5)
                        }
                            .foregroundColor(.white)
                    )
            }
            .contextMenu{
                Button(lecture.name){}
                Button(lecture.location){}
                Button(lecture.teacher){}
            }
        }
    }
}
