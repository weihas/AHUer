//
//  BathView.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import SwiftUI
import MapKit

struct BathView: View {
    @ObservedObject var vm: BathOpenShow
    @Environment(\.colorScheme) var colorScheme
    @State var regin = MKCoordinateRegion(center: .init(latitude: 31.76693, longitude: 117.1848), span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
    
    var body: some View {
        Map(coordinateRegion: $regin, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: vm.bathrooms) { bathroom in
                MapAnnotation(coordinate: bathroom.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    Image(systemName: "mappin.circle.fill")
                        .font(vm.selectedBathroom == bathroom ? .title : .body)
                        .foregroundStyle(bathroom.color)
                        .opacity(0.8)
                        .padding()
                        .onTapGesture {
                            vm.choose(bathroom: bathroom)
                        }
                }
        }
        .ignoresSafeArea(.all, edges: .vertical)
        .overlay(alignment: .topTrailing) {
            contextBox
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    private var contextBox: some View {
        HStack {
            Button {
                vm.pinSelectedBathRoom()
            } label: {
                Image(systemName: vm.currentisPin ? "pin.fill" : "pin")
            }
            
            VStack {
                Text(vm.borderTime)
                Text(vm.boardTitle)
                Text(vm.boardSubtitle)
            }
            
            Button {
                vm.freshBathroom()
            } label: {
                Image(systemName: "gobackward")
            }

        }
        .padding()
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(vm.selectedBathroom.color)
                .shadow(radius: 5)
        )
        .padding()
        
        .opacity(0.8)
    }
}

//fileprivate struct CardOfBathView: View {
//    var date: Date
//    var northisMen: Bool
//    var isToday: Bool
//
//    var todayOfweek: String {
//        return (isToday ? "今日" : "明日") + "-" + "\(date.weekDayInChinese)"
//    }
//
//    var dateString: String {
//        let year = "\(date.year)"
//        let month = "-\(date.month)-"
//        let day = "\(date.day)"
//        return year + month + day
//    }
//
//    var timeScope: String = "10:30-21:00"
//
//    var body: some View {
//        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
//            .foregroundColor(isToday ? .green : .pink )
////            .opacity(0.6)
//            .shadow(radius: 8)
//            .overlay {
//                VStack{
//                    HStack{
//                        Spacer()
//                        VStack(alignment: .trailing, spacing: nil){
//                            Text(todayOfweek)
//                            Text(dateString)
//                            Text(timeScope)
//                        }
//                        .padding()
//                    }
//                    HStack{
//                        VStack{
//                            Text(northisMen ? "北区" : "南区/蕙园")
//                                .font(.title)
//                            Text("男生")
//                                .padding()
//                        }
//                        .padding()
//                        Spacer()
//                        VStack{
//                            Text(northisMen ? "南区/蕙园" : "北区")
//                                .font(.title)
//                            Text("女生")
//                                .padding()
//                        }
//                        .padding()
//                    }
//                }
//                .foregroundColor(.white)
//            }
//    }
//}


//struct BathView_Previews: PreviewProvider {
//    static var previews: some View {
//        BathView(vm: BathOpenShow())
//    }
//}
