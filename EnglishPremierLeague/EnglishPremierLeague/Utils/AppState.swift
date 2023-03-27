//
//  AppState.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import Foundation

enum AppState {
    enum EmptyStateType {
        case allMatches
        case favorites
    }

    case loading
    case success([String])
    case update([String])
    case failure(AppError)
}
