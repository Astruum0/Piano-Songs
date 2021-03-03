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
    @EnvironmentObject var userData: UserData
    
    @FetchRequest(entity: Song.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var songs: FetchedResults<Song>
    
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showLearnedOnly) {
                    Text("Show learned songs only")
                }
                ForEach(songs) { song in
                    if (!userData.showLearnedOnly || song.learned) {
                        NavigationLink(destination: SongDetail(song: song, SongVM: SongVM)) {
                        SongRow(song: song)
                    }
                    }

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
                NewSongView(isPresented: $newSongViewOn)
            }
        }
        
    }
}

