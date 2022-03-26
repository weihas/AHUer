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
                LectureCard(course: course)
                    .matchedGeometryEffect(id: course.geometryID, in: namespace)
            }
        }
    }
    
}

struct LectureCard: View {
    var course: ScheduleInfo
    var body: some View {
        HStack{
            timeLine
            RoundedRectangle(cornerRadius: 10)
                .fill(course.color)
                .aspectRatio(2, contentMode: .fit)
                .padding()
                .overlay(alignment: .leading){
                    VStack(alignment: .leading){
                        Text(course.name ?? "")
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
                    .foregroundColor(.white)
                    .padding()
                }
        }
    }
    
    
    var timeLine: some View {
        TimeStripsView(color: .blue, isNow: true)
            .transition(.scale)
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
