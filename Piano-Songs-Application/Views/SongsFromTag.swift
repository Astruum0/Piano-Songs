//
//  SongsFromTag.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct SongsFromTag: View {
    var tagName: String
    @ObservedObject var SongVM: SongViewModel
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(entity: Song.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "artist", ascending: true)])
    var songs: FetchedResults<Song>
    
    var fetchRequest: FetchRequest<Tag>
    var tag: FetchedResults<Tag> { fetchRequest.wrappedValue }
    
    init(tagName: String, SongVM: SongViewModel) {
        self.tagName = tagName
        self.SongVM = SongVM
        
        fetchRequest = FetchRequest<Tag>(entity: Tag.entity(),
                      sortDescriptors: [],
                      predicate: NSPredicate(format: "name == %@", tagName))
    }
    
    
    
    var body: some View {
            List {
                ForEach(songs) { song in
                    if let songTags = song.tags {
                        if songTags.contains(tag[0]) {
                            NavigationLink(destination: SongDetail(song: song, SongVM: SongVM)) {
                                SongRow(song: song)
                            }
                        }
                    }

                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(self.tagName)
            
    }
}
