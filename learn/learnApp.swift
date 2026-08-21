//
//  learnApp.swift
//  learn
//
//  Created by Cindy Michalowski on 8/21/26.
//

import SwiftUI
import CoreData

@main
struct learnApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
