//
//  SongsFromTag.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct SongsFromTag: View {
    var tag: String
    
    var body: some View {
            List {
//                ForEach(userData.allSongs) { song in
//                    if let songTags = song.tags {
//                        if songTags.contains(tag) {
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