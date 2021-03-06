//
//  ScheduleGalleryView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/26.
//

import SwiftUI

struct ScheduleGalleryView: View {
    var namespace: Namespace.ID
    var day: ScheduleDay
    var body: some View {
        VStack{
            ForEach(day.solidCourse) { course in
                LectureCard(course: course, isToday: day.weekday?.rawValue == Date().weekDay)
                    .matchedGeometryEffect(id: course.geometryID, in: namespace)
                    .padding(.vertical, 8)
            }
        }
    }
    
}

struct LectureCard: View {
    var course: ScheduleInfo
    var isToday: Bool = false
    var body: some View {
        HStack {
            timeLine
            RoundedRectangle(cornerRadius: 20)
                .fill(course.color)
                .aspectRatio(2, contentMode: .fit)
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading){
                        Text((course.name ?? ""))
                            .fontWeight(.medium)
                            .font(.title2)
                            .minimumScaleFactor(0.7)
                        Label(" x \(course.length)" , systemImage: "clock")
                        Spacer()
                        HStack {
                            Label(course.teacher ?? "", systemImage: "person")
                            Label(course.location ?? "", systemImage: "location")
                        }
                        .lineLimit(1)
                        .font(.footnote)
                    }
                    .padding()
                    .foregroundColor(.white)
                }
                .scaleEffect(isNow ? 1 : 0.9, anchor: .leading)
                .padding(.trailing)
                .shadow(radius: 10)
        }
    }
    
    var isNow: Bool {
//        Date().startTime == course.time.rawValue
        isToday && course.time == .third
    }
    
    var timeLine: some View {
        TimeStripsView(color: .blue, startTime: course.time, length: course.length, isNow: isNow)
            .padding(.horizontal)
//            .animation(.easeOut.delay(Double(course.id) * 0.05))
    }
}

struct ScheduleGalleryView_Previews: PreviewProvider {
    @Namespace static var name
    static var previews: some View {
        NavigationView{
            ScheduleGalleryView(namespace: name, day: .init(weekday: .Wed, courses: [
                .init(id: 0, name: "????????????????????????????????????", teacher: "??????", location: "??????A123", courseID: "GG12345", style: .two),
                .init(id: 1, name: "????????????", teacher: "??????", location: "??????A124", courseID: "GG12346", style: .two),
                .init(id: 2, name: "????????????", teacher: "??????", location: "??????A125", courseID: "GG12347", style: .two)
            ]))
            .navigationTitle("???11???")
        }
    }
}
