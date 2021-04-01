//
//  SongList.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

struct SongList: View {
    @ObservedObject var SongVM:SongViewModel
    @Environment(\.managedObjectContext) var context
    @State var newSongViewOn: Bool = false
    
    @FetchRequest(entity: Song.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "artist", ascending: true)])
    var songs: FetchedResults<Song>
    
    
    var body: some View {
        NavigationView {
            
            List {
                if songs.count > 0 {
                    Toggle(isOn: $SongVM.showLearnedOnly) {
                        Text("Show learned songs only")
                    }
                    ForEach(songs) { song in
                        if (!SongVM.showLearnedOnly || song.learned) {
                            NavigationLink(destination: SongDetail(song: song, SongVM: SongVM)) {
                            SongRow(song: song)
                            }
                        }
                    }.onDelete(perform: { indexSet in
                        self.SongVM.deleteSong(song: songs[indexSet.first!], context: context)
                    })
                } else {
                    Text("No song posted yet, click the '+' button !")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Piano Songs"))
            .navigationBarItems(trailing:
                Button(action: { self.newSongViewOn.toggle() }) {
                    HStack {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }
            ).sheet(isPresented: $newSongViewOn) {
                NewSongView(SongVM: SongVM)
            }
        }
        
    }
}

