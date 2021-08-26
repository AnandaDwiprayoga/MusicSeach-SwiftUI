//
//  MusicSearchApp.swift
//  MusicSearch
//
//  Created by paslang on 25/08/21.
//

import SwiftUI

@main
struct MusicSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SongViewModel())
        }
    }
}
