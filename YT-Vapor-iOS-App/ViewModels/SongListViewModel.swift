//
//  SongListViewModel.swift
//  YT-Vapor-iOS-App
//
//  Created by Saidou on 21/07/2022.
//

import SwiftUI
class SongListViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseUrl + Endpoints.songs
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let songResponse:[Song] = try await HttpClient.shard.fetch(url: url)
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
        guard let songID = songs[i].id else { return }
            guard let url = URL(string: Constants.baseUrl + Endpoints.songs + "/\(songID)") else {return}
          
            Task {
                do{
                    try await HttpClient.shard.delete(at: songID, url: url)
                } catch {
                    print("Error Delete \(error)")
                }
            }
        }
        songs.remove(atOffsets: offsets)
    }
    
}
