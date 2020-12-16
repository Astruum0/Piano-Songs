//
//  song.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 23/10/2020.
//

import SwiftUI
import CoreLocation

struct Song: Hashable, Codable, Identifiable {

    var id: Int
    var name: String
    var artist: [String]?
    var tags: [String]?
    var BPM: Int?
    var coverURL: URL?
    var videoURL: URL?
    var learned: Bool
//    fileprivate var imageName: String?
    
    func printArtists() -> String {
        var res: String = ""
        if let allArtists = artist  {
            for (i, a) in allArtists.enumerated() {
                res += a
                if (i < allArtists.count - 1) {
                    res += ", "
                }
            }
        } else {
            res = "Unknown Artist"
        }
        return res
    }
}

//enum tag: String, CaseIterable, Codable, Hashable {
//    case pop = "Pop"
//    case electro = "Electro"
//    case film = "Film"
//    case sad = "Sad"
//    case dance = "Dance"
//}

//extension Song {
//    var image: Image {
//        ImageStore.shared.image(imageName: imageName)
//    }
//}


