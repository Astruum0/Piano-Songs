//
//  SongsFromArtist.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct SongsFromArtist: View {
    var artist: String
    
    var body: some View {
            List {
//                ForEach(userData.allSongs) { song in
//                    if let songArtists = song.artist {
//                        if songArtists.contains(artist) {
//                            NavigationLink(destination: SongDetail(song: song)) {
//                                SongRow(song: song)
//                            }
//                        }
//                    }
//
//                }
            }
            .listStyle(InsetGroupedListStyle())
        
    }
}
