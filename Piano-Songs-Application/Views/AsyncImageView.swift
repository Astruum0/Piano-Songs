//
//  AsyncImageView.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 31/03/2021.
//

import SwiftUI


struct AsyncImageForNewSong: View {
    @StateObject private var loader: ImageLoader
    @ObservedObject var SongVM: SongViewModel
    var state:imageType
    
    init(songVM: SongViewModel, type: imageType) {
        
        self.SongVM = songVM
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: songVM.coverUrl)!))
        state = type
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            switch state {
                case .large:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                case .small:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable().frame(width: 50, height: 50)
                    } else {
                        Image("default").resizable().frame(width: 50, height: 50)
                    }
                    
                case .medium:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
            }
            
            
        }
    }
}

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader

    var state:imageType
    var url: URL
    
    init(url: URL, type: imageType) {
        
        self.url = url
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        state = type
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            switch state {
                case .large:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                case .small:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable().frame(width: 50, height: 50)
                    } else {
                        Image("default").resizable().frame(width: 50, height: 50)
                    }
                    
                case .medium:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
            }
            
            
        }
    }
}

