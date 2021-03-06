//
//  LectureCell.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

struct LectureCell: View {
    @EnvironmentObject var scheduleVM: ScheduleShow
    let course: ScheduleInfo
    var cornerRadius: Double = 10
    var body: some View {
        Group{
            switch course.style {
            case .hide:
                EmptyView()
            case .spacer:
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.clear)
                    .aspectRatio(course.style.aspectRatio, contentMode: .fit)
            case .four:
                VStack{
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.clear)
                        .aspectRatio(0.5, contentMode: .fit)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.clear)
                        .aspectRatio(0.5, contentMode: .fit)
                }
                .background {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(course.color)
                }
                .overlay(alignment: .top) {
                    content
                }
                .contextMenu {
                    contextMenu
                }
            default:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(course.color)
                    .aspectRatio(course.style.aspectRatio, contentMode: .fit)
                    .overlay(alignment: .top) {
                        content
                    }
                    .contextMenu {
                        contextMenu
                    }
                    
            }
        }
    }
    
    var contextMenu: some View {
        Group{
            Text(course.courseID ?? "")
            Text(course.name ?? "")
            Text(course.teacher ?? "")
            Text(course.location ?? "")
            Divider()
//            Button {
//                #warning("Edit")
//            } label: {
//                Text("Edit")
//            }

            Button(role: .destructive) {
                course.remove()
                scheduleVM.freshModel()
            } label: {
                Text("Remove")
            }
        }
    }
    
    var lineLimit: Int {
        if course.length == 3 {
            return 4
        } else if course.length == 4 {
            return 5
        } else {
            return 3
        }
    }
    
    var content: some View {
        VStack {
            if let name = course.name {
                Text(name)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(lineLimit)
            } else if course.isTimeLine {
                Text(course.time.description)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(lineLimit)
                    .foregroundColor(.primary)
                    .background {
                        Capsule()
                    }
            }
            Spacer()
            if let location = course.location {
                Text(location)
                    .font(.footnote)
                    .minimumScaleFactor(0.5)
                    .lineLimit(location.count > 10 ? 3 : 2)
//                    .truncationMode(.tail)
            }
        }
        .padding(5)
    }
    
}

#if DEBUG
struct LectureCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top){
            LectureCell(course: .init(id: 0, style: .one))
            LectureCell(course: .init(id: 1, style: .two))
            LectureCell(course: .init(id: 1, style: .three))
            LectureCell(course: .init(id: 1, style: .four))
            
            LectureCell(course: .init(id: 1, style: .hide))
                .border(Color.black, width: 1)
            
            LectureCell(course: .init(id: 1, style: .spacer(length: 1)))
                .border(Color.black, width: 1)
            LectureCell(course: .init(id: 1, style: .spacer(length: 2)))
                .border(Color.black, width: 1)
            LectureCell(course: .init(id: 1, style: .spacer(length: 3)))
                .border(Color.black, width: 1)
            LectureCell(course: .init(id: 1, style: .spacer(length: 4)))
                .border(Color.black, width: 1)

        }
        .border(Color.black, width: 1)
    }
}
#endif
