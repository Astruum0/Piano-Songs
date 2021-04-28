//
//  ArtistList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI


struct ArtistList: View {
    
    @ObservedObject var SongVM:SongViewModel
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< SongVM.allArtists.count) { value in
                    NavigationLink(destination: SongsFromArtist(artist: SongVM.allArtists[value], SongVM: SongVM)) {
                        Text(SongVM.allArtists[value])
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Artists")
        }.onAppear(perform: {
            self.SongVM.updateAllArtists(context: context)
        })
    }
}
