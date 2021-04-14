//
//  SongRow.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

struct SongRow: View {
    @ObservedObject var song: Song
    var showBPM: Bool = false
    
    init(song: Song, showBPM: Bool = false) {
        self.song = song
        self.showBPM = showBPM
    }
    
    var body: some View {
        HStack {
            if let url = song.coverUrl {
                AsyncImage2(url: URL(string: url)!,
                              placeholder: { Text("Loading ...") },
                              image: { Image(uiImage: $0).resizable() })
                    .frame(width: 50, height: 50)
                //AsyncImage(url: URL(string: url)!, type: .small)
            } else {
                Image("default").resizable().frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(song.name ?? "Unknown")
                    .font(.headline)
                    
                    
                Text(song.artist ?? "Unknown")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                        
            }
            Spacer()
            
            if showBPM {
                Text("\(song.bpm) BPM")
                    .fontWeight(.semibold)
            } else {
                Image(systemName: song.learned ? "book.fill" : "book" ).imageScale(.medium).foregroundColor(song.learned ? .blue : .gray)
                    .padding()
            }
        }
    }
}
