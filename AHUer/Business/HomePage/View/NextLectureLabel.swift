//
//  NextLectureLabel.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/11.
//

import SwiftUI

struct NextLectureLabel: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    var courseName: String
    
    var courseProgress: (progress: Double, label: String)
    
    var startTime: String
    
    var teacher: String
    
    var location: String
    
    var body: some View {
        GroupBox {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.imageBlue)
                .aspectRatio(2, contentMode: .fit)
                .shadow(radius: 10)
                .overlay {
                    haveNextLecture
                }
        } label: {
            Label("即将开始", systemImage: "bolt")
        }
        .padding([.horizontal,.bottom])
    }
    
    var haveNextLecture: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                Text(courseName)
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Button {
                    appInfo.tabItemNum = .schedulePage
                } label: {
                    Image(systemName: "align.horizontal.left")
                }
            }
            .foregroundColor(.white)
            
            ProgressView(value: courseProgress.progress) {
                Label(courseProgress.label, systemImage: "clock.badge.checkmark")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .white))
            
            Group{
                Label(startTime , systemImage: "clock")
                Label(teacher, systemImage: "person")
                Label(location, systemImage: "location")
            }
            .font(.footnote)
            .foregroundColor(.white)
        }
        .padding()
    }
}

#if DEBUG
struct NextLectureLabel_Previews: PreviewProvider {
    static var previews: some View {
        NextLectureLabel(courseName: "高等数学", courseProgress: (0.8, "剩余次数: 11/18"), startTime: "8:20 - 10:00", teacher: "Lucy", location: "博北某地")
    }
}
#endif
