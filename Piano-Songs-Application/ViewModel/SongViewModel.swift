//
//  SongViewModel.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 03/03/2021.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class SongViewModel: ObservableObject {
    @Published var showLearnedOnly = false
    
    @Published var name = ""
    @Published var artist = ""
    @Published var videoUrl = ""
    @Published var bpm = 0
    @Published var bpmStr = ""
    @Published var coverUrl = ""
    @Published var learned = false
    
    @Published var tags = [String]()
    @Published var updated = false
    
    @Published var allArtists = [String]()
    @Published var allTags = [String]()
    
    @Published var dataSource: [SongFromDeezerViewModel] = []
    
    @Published var sheetOn = false

    @Published var bpmResponses: [SongFromBPMViewModel] = []
    
    private let songFetcher: SongFetchable = SongFetcher()
    private var disposables = Set<AnyCancellable>()
    
    private let songBpmFetcher: SongBpmFetchable = SongBpmFetcher()
    private var disposablesBpm = Set<AnyCancellable>()
    
    fileprivate let tagReq = NSFetchRequest<Tag>(entityName: "Tag")
    fileprivate let songReq = NSFetchRequest<Song>(entityName: "Song")
    
    func addDefaultSongs(context: NSManagedObjectContext) {
        
        let newSong = Song(context: context)
        
        tags = ["Film", "Sad"]
        newSong.name = "Cornfield Chase - Interstellar"
        newSong.artist = "Hans Zimmer"
        newSong.bpm = 100
        newSong.videoUrl = "https://www.youtube.com/watch?v=4y33h81phKU"
        newSong.coverUrl = "https://e-cdns-images.dzcdn.net/images/cover/5a02690056ec7f97030788109498ac5a/1000x1000-000000-80-0-0.jpg"
        newSong.learned = false
        
        for currentTag in tags {
            tagReq.predicate = NSPredicate(format: "name == %@", currentTag)

            do {
                let currentTagFetch = try context.fetch(tagReq)[0]
                currentTagFetch.addToSongs(newSong)
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func addArtist(context: NSManagedObjectContext) {
        let newSong = Song(context: context)
        
        if (self.name != "") {
            newSong.name = self.name
        }
        if (self.artist != "") {
            newSong.artist = self.artist
        }
        if let bpm = Int64(bpmStr) {
            newSong.bpm = bpm
        }
        if (self.videoUrl != "") {
            newSong.videoUrl = self.videoUrl
            
        }
        if (self.coverUrl != "") {
            newSong.coverUrl = self.coverUrl
        }
        newSong.learned = false
        
        for currentTag in self.tags {
            tagReq.predicate = NSPredicate(format: "name == %@", currentTag)

            do {
                let currentTagFetch = try context.fetch(tagReq)[0]
                currentTagFetch.addToSongs(newSong)
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        resetValues()
        sheetOn = false
    }
    func resetValues() {
        name = ""
        artist = ""
        videoUrl = ""
        bpm = 0
        bpmStr = ""
        coverUrl = ""
        tags = [String]()
    }
    
    func updateAllArtists(context: NSManagedObjectContext) {
        do {
            let songs = try context.fetch(songReq)
            var unknownIn = false
            for song in songs {
                if song.artist == nil && !unknownIn {
                    allArtists.append("Unknown")
                    unknownIn = true
                } else if (!allArtists.contains(where: {$0 == song.artist})) {
                    allArtists.append(song.artist!)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAllTags(context: NSManagedObjectContext) {
        allTags = []
        do {
            let tags = try context.fetch(tagReq)
            for tag in tags {
                if tag.name != nil && !allTags.contains(tag.name!){
                    allTags.append(tag.name!)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toggleLearnedSong(song: Song, context: NSManagedObjectContext) {
        
        song.setValue(!song.learned, forKey: "learned")
        self.updated.toggle()
        
        do {
            try context.save()
            self.learned = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteSong(song: NSManagedObject, context: NSManagedObjectContext) {
        context.delete(song)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchSongs() {
        self.coverUrl = ""
        songFetcher.SongForecast(songName: self.name, artist: self.artist)
        .map { response in
          response.data.map(SongFromDeezerViewModel.init)
        }
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              self.dataSource = []
            case .finished:
                self.updateData()
              break
            }
          },
          receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.dataSource = forecast
        })
        .store(in: &disposables)
        
        
        
        
    }
    func updateData() {
        if dataSource.count > 0 {
            self.name = dataSource[0].songName
            self.artist = dataSource[0].artist
            self.coverUrl = dataSource[0].cover
            
            self.bpmStr = ""
            
            songBpmFetcher.SongForecast(songName: self.name, artist: self.artist)
            .map { response in
                response.search.map(SongFromBPMViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.bpmResponses = []
                case .finished:
                    if self.bpmResponses.count > 0 {
                        self.bpmStr = self.bpmResponses[0].tempo
                    }
                    
                  break
                }
              },
              receiveValue: { [weak self] forecast in
                guard let self = self else { return }
                self.bpmResponses = forecast
            })
            .store(in: &disposablesBpm)
            
            
        }
        
    }
}
