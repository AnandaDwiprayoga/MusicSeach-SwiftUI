//
//  SongData.swift
//  MusicSearch
//
//  Created by paslang on 25/08/21.
//

import Foundation

class DataModel {
    private var dataTask: URLSessionDataTask?
    
    func loadSongs(searchTerm: String, completion: @escaping(([Song]) -> Void)) {
        dataTask?.cancel()
        
        guard let url = buildUrl(forTerm: searchTerm) else {
            completion([])
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url){data,_,_ in
            guard let data = data else {
                completion([])
                return
            }
            
            let songResponse = self.decodeData(data: data)
            guard let songs = songResponse as? [Song] else {return}
            completion(songs)
        }
        
        dataTask?.resume()
    }
    
    private func decodeData(data: Data) -> [Song?]{
        if let dataDecoded = try? JSONDecoder().decode(SongResponse.self, from: data){
            return dataDecoded.songs
        }
        
        return []
    }
    
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "song"),
        ]
        var components = URLComponents(string: "https://itunes.apple.com/search")!
        components.queryItems = queryItems
        
        return components.url
    }
}
