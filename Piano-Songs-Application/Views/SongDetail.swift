//
//  SongDetail.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI

struct SongDetail: View {
    
    @ObservedObject var song: Song
    @ObservedObject var SongVM: SongViewModel
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        
        VStack {
            if let url = song.coverUrl {
                AsyncImage(url: URL(string: url)!, type: .large)

            } else {
                Image("default")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFill()
                    .cornerRadius(12.0)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            
            HStack {
                
                VStack {
                    Text(song.name ?? "Unknown")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(song.artist ?? "Unknown")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .padding()
            }
            
            Button(action: {
                self.SongVM.toggleLearnedSong(song: song, context: context)
            }) {
                if (song.learned) {
                    Image(systemName: "book.fill")
                        .foregroundColor(.blue).imageScale(.large)
                } else {
                    Image(systemName: "book")
                        .foregroundColor(.gray).imageScale(.large)
                }
            }.padding()
            
            
            if let songBPM = song.bpm {
                HStack {
                    Text("\(String(songBPM)) BPM").italic()
                    Image(systemName: "metronome").imageScale(.medium)
                }
                
            }
            HStack {
                if song.tags != nil {
                    ForEach(song.tags?.allObjects as! [Tag], id: \.self) { tag in
                        
                        
                        HStack {
                            Image(systemName: "tag")
                                .imageScale(.small)
                            Text(tag.name ?? "Unknown")
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
            
            if let songURL = song.videoUrl {
                Link(destination: URL(string: songURL)!) {
                    Text("Video")
                    Image(systemName: "play.rectangle.fill")
                }
            }
            Spacer()
        }
        
    }
}

