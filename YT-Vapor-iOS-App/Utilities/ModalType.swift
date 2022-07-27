//
//  ModalType.swift
//  YT-Vapor-iOS-App
//
//  Created by Saidou on 22/07/2022.
//

import Foundation
import SwiftUI

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    case add
    case update(Song)
}
