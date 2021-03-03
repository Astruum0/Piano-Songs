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
    
    var body: some View {
        NavigationView {
            
            List {
//                VStack {
//                    Text("Range: \((BPMrange-5).clean) - \((BPMrange + 5).clean) BPM")
//                    Slider(value: $BPMrange, in: 40...200, step: 1)
//                }
//                ForEach(userData.allSongs) { song in
//                    if song.BPM != nil && inRangeBPM(song.BPM!, BPMrange) {
//                        NavigationLink(destination: SongDetail(song: song)) {
//                            SongRow(song: song, showBPM: true)
//                        }
//                    }
//
//                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Songs by BPM"))
        }
    }
}
