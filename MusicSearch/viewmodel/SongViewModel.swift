//
//  SongViewModel.swift
//  MusicSearch
//
//  Created by paslang on 25/08/21.
//

import Combine
import Foundation

class SongViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongModel] = []
    
    private let dataModel: DataModel = DataModel()
    private let arworkLoader: ImageArworkLoader = ImageArworkLoader()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .sink(receiveValue: loadSongs(searchQuery:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchQuery: String){
        songs.removeAll()
        arworkLoader.reset()
        
        dataModel.loadSongs(searchTerm: searchQuery){songs in
//            let songViewModel = SongModel(song: <#T##Song#>)
            songs.forEach { song in
                self.appendSong(song: song)
            }
        }
    }
    
    private func appendSong(song: Song){
        let songModel = SongModel(song: song)
        DispatchQueue.main.async {
            self.songs.append(songModel)
        }
        
        arworkLoader.loadArwork(forSong: song) { image in
            DispatchQueue.main.async {
                songModel.artwork = image
            }
        }
    }
}
