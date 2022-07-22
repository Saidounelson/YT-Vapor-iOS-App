//
//  ContentView.swift
//  YT-Vapor-iOS-App
//
//  Created by Saidou on 20/07/2022.
//

import SwiftUI

struct SongList: View {
    @StateObject var viewModel = SongListViewModel()
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.songs) { song in
                    
                    Button {
                        print("Selected")
                    } label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                        
                    }
                    
                }
            }
            .navigationTitle(Text(" Songs"))
            .toolbar{
                Button{
                    
                } label: {
                    Label("Add song",systemImage:"plus.circule")
                }
            }
        }
        .onAppear {
            Task{
                do {
                    try await viewModel.fetchSongs()
                }catch{
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
