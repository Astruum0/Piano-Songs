//
//  SongRow.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

struct SongRow: View {
    var song: Song

    
    var body: some View {
        HStack {
            if let url = song.coverURL {
                AsyncImage(url: url, type: .small)
            } else {
                Image("default").resizable().frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .font(.headline)
                    
                    
                Text(song.printArtists())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                        
            }
            Spacer()
            
            Image(systemName: song.learned ? "book.fill" : "book" ).imageScale(.medium).foregroundColor(song.learned ? .blue : .gray)
                .padding()
            
            
        }
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: songsData[0])
    }
}
