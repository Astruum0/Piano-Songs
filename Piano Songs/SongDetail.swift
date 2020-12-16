//
//  SongDetail.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

struct SongDetail: View {
    @EnvironmentObject var userData: UserData
    var song: Song
    
    var songIndex: Int {
            userData.allSongs.firstIndex(where: { $0.id == song.id })!
        }
    
    var body: some View {
        
        VStack {
            
            if let url = song.coverURL {
                AsyncImage(url: url, type: .large)
                
            } else {
                GeometryReader { geo in
                Image("default")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
            }
            
            
            HStack {
                
                VStack {
                    Text(song.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(song.printArtists())
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
            }
            
            Button(action: { self.userData.allSongs[self.songIndex].learned.toggle()
            }) {
                if (self.userData.allSongs[self.songIndex].learned) {
                    Image(systemName: "book.fill")
                        .foregroundColor(.blue).imageScale(.large)
                } else {
                    Image(systemName: "book")
                        .foregroundColor(.gray).imageScale(.large)
                }
            }.padding()
            
            
            if let songBPM = song.BPM {
                HStack {
                    Text("\(String(songBPM)) BPM").italic()
                    Image(systemName: "metronome").imageScale(.medium)
                }
                
            }
            HStack {
                if let songTags = song.tags {
                    ForEach(songTags, id: \.self) { tag in
                        HStack {
                            Image(systemName: "tag")
                                .imageScale(.small)
                            Text(tag)
                        }
                        .padding(.all, 5.0)
                        .padding(.horizontal, 2.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white)
                        )
                    }
                }
            }
            .padding()
            
            if let songURL = song.videoURL {
                Link(destination: songURL) {
                    Text("Video")
                    Image(systemName: "play.rectangle.fill")
                }
            }
            
            Spacer()
        }
        
    }
}

struct SongDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SongDetail(song: songsData[0]).environmentObject(UserData())
        }
    }
}

