//
//  SongResponse.swift
//  MusicSearch
//
//  Created by paslang on 25/08/21.
//

import Foundation

//https://itunes.apple.com/search?term=coldplay&entity=song

struct SongResponse : Codable {
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}


struct Song: Codable {
    let id: Int
    let trackName: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName, artistName
        case artworkUrl = "artworkUrl60"
    }
}
