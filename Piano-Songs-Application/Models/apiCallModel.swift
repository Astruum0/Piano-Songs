//
//  apiCallModel.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 17/03/2021.
//

import Foundation

struct SongResponse: Codable {
    var data: [SongFromDeezer]
    
    struct SongFromDeezer: Codable {
        var title_short:String
        var artist: Artist
        var album: Album
        
        struct Artist: Codable {
            var name: String
        }
        struct Album: Codable {
            var cover_big: String
        }
    }
}

enum SongError: Error {
  case parsing(description: String)
  case network(description: String)
}
