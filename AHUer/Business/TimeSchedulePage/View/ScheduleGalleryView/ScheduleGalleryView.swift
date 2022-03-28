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
                .shadow(radius: 5)
                .aspectRatio(2, contentMode: .fit)
                .padding()
                .scaleEffect(isNow ? 1 : 0.9, anchor: .leading)
                .overlay(alignment: .leading){
                    VStack(alignment: .leading){
                        Text((course.name ?? "") + "x\(course.length)")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding()
                        Group{
                            Label(course.time.description , systemImage: "clock")
                            Label(course.teacher ?? "", systemImage: "person")
                            Label(course.location ?? "", systemImage: "location")
                        }
                        .padding(.leading)
                        .font(.footnote)
                    }
                    .padding(.bottom)
                    .foregroundColor(.white)
                    .padding()
                }
        }
    }
    
    var isNow: Bool {
//        Date().startTime == course.time.rawValue
        isToday && course.time == .third
    }
    
    var timeLine: some View {
        TimeStripsView(color: .blue, startTime: course.time, length: course.length, isNow: isNow)
            .padding(.horizontal)
            .animation(.easeOut.delay(Double(course.id) * 0.05))
    }
}

struct ScheduleGalleryView_Previews: PreviewProvider {
    @Namespace static var name
    static var previews: some View {
        NavigationView{
            ScheduleGalleryView(namespace: name, day: .init(weekday: .Wed, courses: [
                .init(id: 0, name: "高等数学", teacher: "张飞", location: "博北A123", courseID: "GG12345", style: .two),
                .init(id: 1, name: "高等英语", teacher: "刘备", location: "博北A124", courseID: "GG12346", style: .two),
                .init(id: 2, name: "高等语文", teacher: "关羽", location: "博北A125", courseID: "GG12347", style: .two)
            ]))
            .navigationTitle("第11周")
        }
    }
}
