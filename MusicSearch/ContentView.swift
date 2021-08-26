//
//  ContentView.swift
//  MusicSearch
//
//  Created by paslang on 25/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SongViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchQuery: $viewModel.searchTerm)
                if viewModel.songs.isEmpty {
                    EmptyStateView()
                }else{
                    List(viewModel.songs){song in
                        SongView(song: song)
                    }
                    .listStyle(PlainListStyle())
                }
            }.navigationBarTitle("Music Search")
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
           Spacer()
            Image(systemName: "music.note")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for music...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}

struct SongView: View {
    @ObservedObject var song: SongModel
    
    var body: some View {
        HStack {
            ArtworkView(image: song.artwork)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistname)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct ArtworkView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                image
            }else{
                Color(.systemIndigo)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 60, height: 60)
        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}

//extends UIViewRepresentable to embed UIkit to Swift UI
struct SearchBar: UIViewRepresentable {
    
    typealias UIViewType = UISearchBar
    
    @Binding var searchQuery: String
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
    
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type a song, artist or album name"
        return searchBar
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searhTerm: $searchQuery)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchQuery: String
        
        init(searhTerm: Binding<String>) {
            self._searchQuery = searhTerm
        }
        
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
//            searchQuery = searchBar.text ?? ""
//            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
//        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchQuery = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SongViewModel())
//        ArtworkView(image: nil)
    }
}
