//
//  SongDetail.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/10/2020.
//

import SwiftUI
import AVKit

struct SongDetail: View {
    
    @ObservedObject var song: Song
    @ObservedObject var SongVM: SongViewModel
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    
                    if let url = song.coverUrl {
                        AsyncImage(url: URL(string: url)!,
                                      placeholder: { Text("Loading ...") },
                                      image: { Image(uiImage: $0).resizable() })
                            .scaledToFit()
                            .blur(radius: 20)
                            
                            

                    } else {
                        Image("default")
                            .resizable()
                            .scaledToFit()
                            .blur(radius: 20)
                            
                    }
                    Spacer()
                }
            
            
            VStack {
                if let url = song.coverUrl {
                    AsyncImage(url: URL(string: url)!,
                                  placeholder: { Text("Loading ...") },
                                  image: { Image(uiImage: $0).resizable() })
                        .frame(width: 300, height: 300)
                        .scaledToFill()
                        .cornerRadius(12.0)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.top, 20)

                } else {
                    Image("default")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .scaledToFill()
                        .cornerRadius(12.0)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .padding(.top, 18)
                }
                
                HStack {
                    
                    VStack {
                        Text(song.name ?? "Unknown")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .shadow(radius: 20)
                        Text(song.artist ?? "Unknown")
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .shadow(radius: 18)
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
                
                
                if song.bpm > 0 {
                    HStack {
                        Text("\(String(song.bpm)) BPM").italic()
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
                
            }
            }
            
        }
    }
}

