//
//  SongModel.swift
//  MusicSearch
//
//  Created by paslang on 25/08/21.
//

import Foundation
import SwiftUI

class SongModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistname: String
    @Published var artwork: Image?
    
    init(song: Song) {
        id = song.id
        trackName = song.trackName
        artistname = song.artistName
    }
}
