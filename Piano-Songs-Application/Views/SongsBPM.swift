//
//  SongsBPM.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 20/01/2021.
//v

import SwiftUI

func inRangeBPM(_ bpm: Int, _ range: Double) -> Bool {
    return (Double(bpm) >= range - 5 && Double(bpm) <= range + 5)
}

struct SongsBPM: View {
    @State private var BPMrange: Double = 100
    
    @ObservedObject var SongVM:SongViewModel
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: Song.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "artist", ascending: true)])
    var songs: FetchedResults<Song>
    
    var body: some View {
        NavigationView {
            
            List {
                VStack {
                    Text("Range: \((BPMrange-5).clean) - \((BPMrange + 5).clean) BPM")
                    Slider(value: $BPMrange, in: 40...200, step: 1)
                }
                ForEach(songs) { song in
                    if inRangeBPM(Int(song.bpm), BPMrange) {
                        NavigationLink(destination: SongDetail(song: song, SongVM: SongVM)) {
                            SongRow(song: song, showBPM: true)
                        }
                    }

                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Songs by BPM"))
        }
    }
}
