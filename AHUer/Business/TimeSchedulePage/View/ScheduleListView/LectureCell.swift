//
//  LectureCell.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/25.
//

import SwiftUI

struct LectureCell: View {
    let course: ScheduleInfo
    var body: some View {
        Group{
            switch course.style {
            case .hide:
                EmptyView()
            case .spacer:
                RoundedRectangle(cornerRadius: 10).fill(Color.clear)
                    .aspectRatio(course.style.aspectRatio, contentMode: .fit)
            case .four:
                VStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .aspectRatio(0.5, contentMode: .fit)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .aspectRatio(0.5, contentMode: .fit)
                }
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(course.color)
                }
                .overlay(alignment: .top) {
                    content
                }
                .contextMenu {
                    contextMenu
                }
            default:
                RoundedRectangle(cornerRadius: 10)
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
            Button(course.courseID ?? "") {}
            Button(course.name ?? "") {}
            Button(course.teacher ?? "") {}
            Button(course.location ?? "") {}
        }
    }
    
    var content: some View {
        VStack{
            if let name = course.name {
                Text(name)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(3)
                    .padding(3)
            } else if course.isTimeLine {
                Text(course.time.description)
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                    .lineLimit(3)
                    .padding(3)
                    .foregroundColor(.primary)
                    .background {
                        Capsule()
                    }
            }
            Spacer()
            if let location = course.location {
                Text(location)
                    .font(.footnote)
                    .minimumScaleFactor(0.6)
                    .lineLimit(location.count > 10 ? 3 : 2)
                    .padding(3)
//                    .truncationMode(.tail)
            }
           
        }
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
