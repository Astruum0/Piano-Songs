//
//  SongFromDeezerViewModel.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 31/03/2021.
//

import Foundation

struct SongFromDeezerViewModel {
    private let data: SongResponse.SongFromDeezer
    
    var artist: String {
        return data.artist.name
    }
    
    var songName: String {
        return data.title_short
    }
    
    var cover: String {
        return data.album.cover_big
    }
    
    init(data: SongResponse.SongFromDeezer) {
        self.data = data
    }
}

struct SongFromBPMViewModel {
    private let data: SongBpmResponse.SongFromBPM
    
    var tempo: String {
        return data.tempo
    }
    
    init(data: SongBpmResponse.SongFromBPM) {
        self.data = data
    }
}
