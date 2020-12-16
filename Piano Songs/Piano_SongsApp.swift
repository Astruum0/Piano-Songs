//
//  Piano_SongsApp.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

@main
struct Piano_SongsApp: App {
    var body: some Scene {
        WindowGroup {
            SongList().environmentObject(UserData())
        }
    }
}
