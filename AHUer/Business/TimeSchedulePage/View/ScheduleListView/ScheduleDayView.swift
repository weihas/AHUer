//
//  ScheduleDayView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

struct ScheduleDayView: View {
    var day: ScheduleDay
    var hideWeekEnd: Bool
    var namespace: Namespace.ID
    var body: some View {
        VStack {
            ForEach(day.courses) { course in
                if course.shouldPadding {
                    Divider()
                        .padding(.vertical , 3)
                }
                LectureCell(course: course, cornerRadius: cornerRadius)
                    .foregroundColor(.background)
                    .shadow(radius: 5)
                    .matchedGeometryEffect(id: course.geometryID, in: namespace)
            }
        }
    }
    
    var cornerRadius: Double {
        hideWeekEnd ? 14 : 10
    }
}

//#if DEBUG
//struct ScheduleDayView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let items = [GridItem(.flexible(minimum: 20), alignment: .top)] + Array(repeating: GridItem(.flexible(minimum: 20), spacing: 10, alignment: .top), count: 5)
//        ScrollView{
//            LazyVGrid(columns: items) {
//                ScheduleDayView(day: .init(weekday: .Mon, courses: testData ))
//                ScheduleDayView(day: .init(weekday: .Tue, courses: testData1 ))
//                ScheduleDayView(day: .init(weekday: .Thur, courses: testData2 ))
//                ScheduleDayView(day: .init(weekday: .Wed, courses: testData3 ))
//                ScheduleDayView(day: .init(weekday: .Fri, courses: testData4 ))
//            }
//        }
////        .previewDevice("iPad Pro (11-inch) (3rd generation)")
//    }
//}
//
//
//var testData: [ScheduleInfo] = [
//    .init(id: 1, style: .two),
//    .init(id: 2, style: .two),
//    .init(id: 3, style: .two),
//    .init(id: 4, style: .two),
//    .init(id: 5, style: .three)
//]
//var testData1: [ScheduleInfo] = [
//    .init(id: 1, style: .two),
//    .init(id: 2, style: .spacer(length: 2)),
//    .init(id: 3, style: .four),
//    .init(id: 4, style: .hide),
//    .init(id: 5, style: .three)
//]
//
//var testData2: [ScheduleInfo] = [
//    .init(id: 1, style: .three),
//    .init(id: 2, style: .spacer(length: 1)),
//    .init(id: 3, style: .two),
//    .init(id: 4, style: .spacer(length: 2)),
//    .init(id: 5, style: .three)
//]
//
//var testData3: [ScheduleInfo] = [
//    .init(id: 1, style: .four),
//    .init(id: 2, style: .hide),
//    .init(id: 3, style: .two),
//    .init(id: 4, style: .two),
//    .init(id: 5, style: .three)
//]
//var testData4: [ScheduleInfo] = [
//    .init(id: 1, style: .spacer(length: 1)),
//    .init(id: 2, style: .three),
//    .init(id: 3, style: .three),
//    .init(id: 4, style: .one),
//    .init(id: 5, style: .spacer(length: 3))
//]
//
//
//#endif
