//
//  NextLectureLabel.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/11.
//

import SwiftUI

struct NextLectureLabel: View {
    @EnvironmentObject var appInfo: AHUAppInfo
    @StateObject var vm: NextLectureLabelShow
    
    var body: some View {
        GroupBox {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .aspectRatio(2, contentMode: .fit)
                .shadow(radius: 10)
                .overlay {
                    haveNextLecture
                }
        } label: {
            Label("即将开始", systemImage: "bolt")
        }
        .padding([.horizontal,.bottom])
        .onAppear {
            vm.freshUser()
            vm.fetchImmediatelyLecture()
        }
    }
    
    var haveNextLecture: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                Text(vm.nextCouseName)
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Button {
                    appInfo.tabItemNum = 1
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            .foregroundColor(.white)
            
            ProgressView(value: vm.nextCourseProcess.value) {
                Label(vm.nextCourseProcess.label, systemImage: "clock.badge.checkmark")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }
            .progressViewStyle(LinearProgressViewStyle(tint: .white))
            
            Group{
                Label(vm.startTime , systemImage: "clock")
                Label(vm.teacherName, systemImage: "person")
                Label(vm.location, systemImage: "location")
            }
            .font(.footnote)
            .foregroundColor(.white)
        }
        .padding()
    }
}


struct NextLectureLabel_Previews: PreviewProvider {
    static var previews: some View {
        NextLectureLabel(vm: NextLectureLabelShow())
    }
}
