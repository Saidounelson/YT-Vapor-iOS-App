//
//  ContentView.swift
//  YT-Vapor-iOS-App
//
//  Created by Saidou on 20/07/2022.
//

import SwiftUI

struct SongList: View {
    @StateObject var viewModel = SongListViewModel()
    @State var modal:ModalType? = nil
    
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.songs) { song in
                    Button {
                        modal = .update(song)
                    } label: {
                        Text(song.title)
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle(Text(" Songs"))
            .toolbar{
                Button{
                    modal = .add
                } label: {
                    Label("Add song",systemImage:"plus.app")
                }
            }
        }
        .sheet(item: $modal, onDismiss: {
            Task{
                do{
                    try await viewModel.fetchSongs()
                } catch {
                   print("Error \(error)")
                }
            }
        }) {
            modal in
            switch modal {
            case .add:
                AddUpdateSong(viewModel: AddUpdateViewModel())
            case .update(let song):
                AddUpdateSong(viewModel: AddUpdateViewModel(currentSong: song))
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
