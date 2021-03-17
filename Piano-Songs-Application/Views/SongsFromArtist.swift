//
//  SongsFromArtist.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI
import CoreData

struct SongsFromArtist: View {
    var artist: String
    
    @ObservedObject var SongVM:SongViewModel
    @Environment(\.managedObjectContext) var context
    @State var newSongViewOn: Bool = false
    var fetchRequest: FetchRequest<Song>
    var songs: FetchedResults<Song> { fetchRequest.wrappedValue }
    
    
    
    init(artist: String, SongVM: SongViewModel) {
        self.artist = artist
        self.SongVM = SongVM
        
        fetchRequest = FetchRequest<Song>(entity: Song.entity(),
                      sortDescriptors: [NSSortDescriptor(key: "artist", ascending: true)],
                      predicate: NSPredicate(format: "artist == %@", artist))
    }
    
    var body: some View {
            List {
                ForEach(songs) { song in
                    if (!SongVM.showLearnedOnly || song.learned) {
                        NavigationLink(destination: SongDetail(song: song, SongVM: SongVM)) {
                        SongRow(song: song, showBPM: false)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(self.artist)
    }
}
