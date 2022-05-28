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
    @State var regin = MKCoordinateRegion(center: .init(latitude: 31.76390, longitude: 117.1848), span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
    @State var trackMode: MapUserTrackingMode = .follow
    
    var body: some View {
        Map(coordinateRegion: $regin, interactionModes: .all, showsUserLocation: true, userTrackingMode: $trackMode, annotationItems: vm.bathrooms) { bathroom in
                MapAnnotation(coordinate: bathroom.coordinate, anchorPoint: CGPoint(x: 0.20, y: 0.5)) {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundStyle(bathroom.color)
                            .font(vm.selectedBathroom == bathroom ? .title : .body)
                            .opacity(0.8)
                        Text(bathroom.name)
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.gray)
                    }
                    .fixedSize()
                    .padding()
                    .contextMenu {
                        Text(bathroom.name)
                        Text(bathroom.openState)
                    }
                    .onTapGesture {
                        vm.choose(bathroom: bathroom)
                    }
                }
        }
        
        .ignoresSafeArea(.all, edges: .top)
        .overlay(alignment: .bottom) {
            contextBox
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.freshBathroom()
                } label: {
                    Image(systemName: "gobackward")
                }
            }
        }
    }
    
    
    private var contextBox: some View {
        VStack {
            Picker(selection: $vm.selectedBathroom) {
                ForEach(vm.bathrooms) { bathroom in
                    Text(bathroom.name)
                        .tag(bathroom)
                }
            } label: {
                Label("浴室选择",systemImage: "drop")
            }
            .pickerStyle(.segmented)
            HStack {
                VStack(alignment: .leading) {
                    Label(vm.borderTime, systemImage: "clock")
                    Divider()
                    Label(vm.boardSubtitle, systemImage: "tornado")
                        .font(.headline)
                }
                .padding()
                Spacer()
                Button {
                    vm.pinSelectedBathRoom()
                } label: {
                    Image(systemName: vm.currentisPin ? "pin.fill" : "pin")
                        .font(.system(size: 15))
                        .padding()
                }
                .background(colorScheme.isLight ? Color.lightGray : Color.gray)
                .cornerRadius(8)
                .shadow(radius: vm.currentisPin ?  0 : 3)
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme.isLight ? .white : .darkGray)
                .shadow(radius: 3, x: 0, y: -3)
        )
        .opacity(0.9)
    }
}


struct BathView_Previews: PreviewProvider {
    static var previews: some View {
        BathView(vm: BathOpenShow())
    }
}
