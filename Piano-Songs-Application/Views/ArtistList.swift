//
//  ArtistList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct ArtistList: View {
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(0 ..< userData.allArtists.count) { value in
//                    NavigationLink(destination: SongsFromArtist(artist: userData.allArtists[value])) {
//                        Text(userData.allArtists[value])
//
//                    }
//
//                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Artists")
        }
    }
}
