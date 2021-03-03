//
//  Piano_Songs_ApplicationApp.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 03/03/2021.
//

import SwiftUI

@main
struct Piano_Songs_ApplicationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(UserData())
        }
    }
}

