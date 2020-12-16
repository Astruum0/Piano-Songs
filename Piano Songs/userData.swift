//
//  userData.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 26/10/2020.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showLearnedOnly: Bool = false
    @Published var allSongs = songsData
}
