//
//  NewSongView.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 17/03/2021.
//

import SwiftUI

struct NewSongView: View {
    @ObservedObject var SongVM: SongViewModel
    @Environment(\.managedObjectContext) private var context
    
    
    init(SongVM: SongViewModel) {
        self.SongVM = SongVM
    }
    
    func cantAdd() -> Bool {
        return self.SongVM.name == "" && self.SongVM.artist == ""
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Song Name")) {
                    TextField(
                    "Song Name",
                        text: $SongVM.name)
                    .disableAutocorrection(true)
                }
                Section(header: Text("Song Artist")) {
                    TextField(
                    "Song Artist",
                        text: self.$SongVM.artist)
                    .disableAutocorrection(true)
                }
                
                Button(action: {
                    self.SongVM.fetchSongs()
                }) {
                    Text("Update song informations").frame(maxWidth: .infinity, alignment: .center)
                }
                Section(header: Text("Auto filled informations")) {
                    HStack {
                        if self.SongVM.coverUrl != "" {
                            AsyncImageFromViewModel(viewModel: self.SongVM,
                                          placeholder: { Text("Loading ...") },
                                          image: { Image(uiImage: $0).resizable() })
                                .frame(width: 100, height: 100)
                                .scaledToFill()
                                .cornerRadius(12.0)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            //AsyncImageForNewSong(songVM: SongVM, type: .medium)
                        } else {
                            Image("default")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFill()
                                .cornerRadius(12.0)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                    
                    VStack (alignment: .leading) {
                        Text(self.SongVM.name).bold()
                        Text(self.SongVM.artist)
                        HStack {
                        Section(header: Text("BPM :")) {
                            TextField("BPM", text: self.$SongVM.bpmStr)
                                .keyboardType(.decimalPad)
                        }
                        }
                    }.padding()
                    }
                }
                Section(header: Text("Youtube Video")) {
                    TextField(
                    "URL",
                        text: self.$SongVM.videoUrl)
                    .disableAutocorrection(true)
                }
                Section(header: Text("Categories")) {
                    List {
                        ForEach(0 ..< SongVM.allTags.count) { value in
                            Button(action: {
                                if self.SongVM.tags.contains(SongVM.allTags[value]) {
                                    self.SongVM.tags.remove(at: SongVM.tags.firstIndex(of: SongVM.allTags[value])!)
                                } else {
                                    self.SongVM.tags.append(SongVM.allTags[value])
                                }
                            }
                            ) {
                                HStack {
                                    Text(SongVM.allTags[value])
                                    if self.SongVM.tags.contains(SongVM.allTags[value]) {
                                        Spacer()
                                        Image(systemName: "checkmark").padding(.trailing, 8)
                                    }
                                }
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                        }
                    }
                }
                
                Button(action: {
                    SongVM.addArtist(context: context)
                    SongVM.updateAllArtists(context: context)
                }) {
                    Text("Add new song").frame(maxWidth: .infinity, alignment: .center)
                }.disabled(cantAdd())
                
            }.navigationBarTitle("New Song")
            .navigationBarItems(trailing:
                    Button(action: { self.SongVM.resetValues() }) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title)
                    }
                }
                
            )
            
            
        }
    }
}

