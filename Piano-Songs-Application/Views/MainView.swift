//
//  MainView.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject var SongVM = SongViewModel()
    @StateObject var TagVM = TagViewModel()
    
    @FetchRequest(entity: Tag.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var tags: FetchedResults<Tag>
    
    @FetchRequest(entity: Song.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var songs: FetchedResults<Song>
    
    var body: some View {
        TabView {
            SongList(SongVM: SongVM)
                .tabItem {
                
                    Image(systemName: "music.note.list")
                    Text("Songs")
            }
            ArtistList(SongVM: SongVM)
                .tabItem {
                    Image(systemName: "music.mic")
                    Text("Artists")
            }
            TagList(SongVM: SongVM, TagVM: TagVM)
                .tabItem {
                    Image(systemName: "tag")
                    Text("Categories")
            }
            SongsBPM(SongVM: SongVM)
                .tabItem {
                    Image(systemName: "music.quarternote.3")
                    Text("BPM")
                }
        }.onAppear(perform: {
            if (self.tags.count == 0) {
                self.TagVM.addDefaultTag(context: context)
            }
            self.SongVM.updateAllTags(context: context)
            if (self.songs.count == 0) {
                self.SongVM.addDefaultSongs(context: context)
            }

        })
    }
}
