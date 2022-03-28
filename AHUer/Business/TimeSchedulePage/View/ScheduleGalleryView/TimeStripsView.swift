//
//  TimeStripsView.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/3/27.
//

import SwiftUI

struct TimeStripsView: View {
    var color: Color = .blue
    var startTime: ScheduleTime
    var length: Int
    var isNow: Bool = false
    var body: some View {
        HStack(alignment: .top){
            VStack{
                Text(startTime.description)
                Spacer()
                Text(startTime.overTime(add: length))
                    .padding(.vertical, 30)
            }
            .frame(width: 50)
            VStack{
                Group {
                    if isNow {
                        doubleCircle
                    } else {
                        singelCircle
                    }
                }
                    .frame(width: 15, height: 15)
                VerticalLine()
                    .stroke(Color.blue, lineWidth: 2)
                    .background(Color.clear)
                    .frame(width: 20)
            }
        }
        
    }
    
    var doubleCircle: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: 2)
            Circle()
                .fill(color)
                .padding(3)
        }
    }
    
    var singelCircle: some View {
        Circle()
            .stroke(color, lineWidth: 2)
            .padding(3)
    }
}

struct VerticalLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}


//struct TimeLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeStripsView()
//    }
//}
