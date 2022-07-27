//
//  AddUpdateSong.swift
//  YT-Vapor-iOS-App
//
//  Created by Saidou on 22/07/2022.
//

import SwiftUI

struct AddUpdateSong: View {
    @ObservedObject var viewModel: AddUpdateViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            TextField("Song title", text: $viewModel.songTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button{
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}

struct AddUpdateSong_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSong(viewModel: AddUpdateViewModel())
    }
}
