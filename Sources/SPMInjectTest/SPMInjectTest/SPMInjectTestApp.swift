//
//  SPMInjectTestApp.swift
//  SPMInjectTest
//
//  Created by JeongCheol Kim on 2022/06/25.
//

import SwiftUI

@main
struct SPMInjectTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
