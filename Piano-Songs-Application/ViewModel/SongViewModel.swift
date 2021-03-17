//
//  SongViewModel.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 03/03/2021.
//

import Foundation
import CoreData

class SongViewModel: ObservableObject {
    @Published var showLearnedOnly = false
    
    @Published var name = ""
    @Published var artist = ""
    @Published var videoUrl = ""
    @Published var bpm = 0
    @Published var coverUrl = ""
    @Published var learned = false
    
    @Published var tags = [String]()
    @Published var updated = false
    
    @Published var allArtists = [String]()
    @Published var allTags = [String]()

    
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
    
}
