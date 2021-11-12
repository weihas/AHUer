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
    var body: some Scene {
        let info = AHUAppInfo(context: persistenceController.container.viewContext)
        WindowGroup {
            RootView()
                .environmentObject(info)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
