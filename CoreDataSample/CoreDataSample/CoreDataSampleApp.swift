//
//  CoreDataSampleApp.swift
//  CoreDataSample
//
//  Created by 0x2ab70001b1 on 2023/8/16.
//

import SwiftUI

@main
struct CoreDataSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
