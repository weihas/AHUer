//
//  BathOpenShow.swift
//  AHUer
//
//  Created by WeIHa'S on 2022/2/7.
//

import Foundation
import SwiftUI
import MapKit

class BathOpenShow: ObservableObject {
    @Published var regin = MKCoordinateRegion(center: .init(latitude: 31.76693, longitude: 117.1848), span: .init(latitudeDelta: 0.015, longitudeDelta: 0.015))
    @Published var selectedBathroom: BathRoom = .Zhu
    @AppStorage(AHUerDefaultsKey.BathRoom.rawValue, store: .standard) var pinBathRoom: Int = 0
    
    
    
    //MARK: -Access to model
    
    var bathrooms: [BathRoom] {
        return BathRoom.allCases
    }
    
    var boardTitle: String {
        selectedBathroom.name
    }
    
    var boardSubtitle: String {
        "开启状态：" + selectedBathroom.openState
    }
    
    var borderTime: String {
        "开启时间：" + "10:30 - 21:00"
    }
    
    var currentisPin: Bool {
        return self.selectedBathroom.id == pinBathRoom
    }
    
    //MARK: -Intent(s)
    
    @MainActor func choose(bathroom: BathRoom) {
        withAnimation {
            HapticManager.impactFeedBack(style: .light)
            self.selectedBathroom = bathroom
        }
    }
    
    func pinSelectedBathRoom() {
        if pinBathRoom != selectedBathroom.id {
            HapticManager.impactFeedBack(style: .waring)
        }
        withAnimation {
            pinBathRoom = self.selectedBathroom.id
        }
    }
    
    func freshBathroom() {
        Task{
            do {
                try await AHUerAPIProvider.bathroom()
                await MainActor.run { [ weak self] in
                    self?.objectWillChange.send()
                }
            } catch {
                await AlertView.showAlert(with: error)
            }
        }
    }
    
    deinit {
        print("🌀BathOpenShow released")
    }
}
