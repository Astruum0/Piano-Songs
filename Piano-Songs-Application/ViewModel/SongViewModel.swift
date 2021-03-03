//
//  SongViewModel.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 03/03/2021.
//

import Foundation
import CoreData

class SongViewModel: ObservableObject {
    @Published var name = ""
    @Published var artist = ""
    @Published var videoUrl = ""
    @Published var bpm = 0
    @Published var coverUrl = ""
    @Published var learned = false
    
    @Published var tags = [String]()
    
    @Published var songToToggle: Song!
    
    fileprivate let tagReq = NSFetchRequest<Tag>(entityName: "Tag")
    
    func addDefaultSongs(context: NSManagedObjectContext) {
        
        let newSong = Song(context: context)
        
        tags = ["Sad", "Film", "Pop"]
        newSong.name = "SkyFall"
        newSong.artist = "Adele"
        newSong.bpm = 76
        newSong.videoUrl = "https://www.youtube.com/watch?v=kUpWP56FmI0"
        newSong.coverUrl = "https://e-cdns-images.dzcdn.net/images/cover/81e6d7baa7f47b804704922412e7a014/1000x1000-000000-80-0-0.jpg"
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
    
    func toggleLearnedSong(song: Song, context: NSManagedObjectContext) {
        
        song.setValue(!song.learned, forKey: "learned")
        
        
        do {
            try context.save()
            self.learned = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
