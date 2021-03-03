//
//  userData.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 26/10/2020.
//

import SwiftUI
import Combine

public class UserData: ObservableObject {
    @Published var showLearnedOnly: Bool = false
    @Published var allSongs = [SongT]()
    var allArtists = [String]()
    var allTags = [String]()
    
    init() {
        self.allSongs = songsData
        self.allArtists = getAllArtists()
        self.allTags = getAllTags()
    }
    
    func getAllArtists() -> [String] {
        var res = [String]()
        
        for song in self.allSongs {
            if let songArtists = song.artist {
                for artist in songArtists {
                    if !res.contains(artist) {
                        res.append(artist)
                    }
                }
            }
        }
        
        return res
    }
    
    func getAllTags() -> [String] {
        var res = [String]()
        
        for song in self.allSongs {
            if let songTags = song.tags {
                for tag in songTags {
                    if !res.contains(tag) {
                        res.append(tag)
                    }
                }
            }
        }
        
        return res
    }
}
