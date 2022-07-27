//
//  AddUpdateViewModel.swift
//  YT-Vapor-iOS-App
//
//  Created by Saidou on 22/07/2022.
//

import SwiftUI

final class AddUpdateViewModel: ObservableObject {
    @Published var songTitle = ""
    var songID:UUID?
    var isUpdating:Bool {
        songID != nil
    }
    var buttonTitle:String {
        songID != nil ? "Update Song":" Add Song"
    }
    init(){}
    init(currentSong: Song){
        self.songTitle = currentSong.title
        self.songID = currentSong.id
    }
    func addSong() async throws {
        
        let urlString = Constants.baseUrl + Endpoints.songs
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let song = Song(id: nil, title: songTitle)
        try await HttpClient.shard.sendData(to: url, object: song, httpMethod: httpMethod.POST.rawValue)
        }
    
    func addUpdateAction(completion:@escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateSong()
                }else {
                   try await addSong()
                }
            }catch {
                print("Error \(error)")
            }
            completion()
        }
    }
    
    func updateSong() async throws {
        print("updateSong")
        let urlString = Constants.baseUrl + Endpoints.songs
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let songToUpdate = Song(id: songID, title: songTitle)
        
        try await HttpClient.shard.sendData(to: url, object: songToUpdate, httpMethod: httpMethod.PUT.rawValue)
        }
    
    
}

