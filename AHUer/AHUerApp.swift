//
//  AHUerApp.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/8.
//

import SwiftUI

@main
struct AHUerApp: App {
    let persistenceController = PersistenceController.shared
    let info = AHUAppInfo()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(info)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

#warning("接入SiriKit")
