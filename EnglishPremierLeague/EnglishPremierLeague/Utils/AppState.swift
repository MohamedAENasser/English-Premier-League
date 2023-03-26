//
//  AppState.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import Foundation

enum AppState: Equatable {
    enum EmptyStateType {
        case allMatches
        case favorites
    }

    case loading
    case success([String])
    case update([String])
    case failure(AppError)

    static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success(let lhsResult), .success(let rhsResult)), (.update(let lhsResult), .update(let rhsResult)):
            return lhsResult == rhsResult
        case(.failure, .failure):
            return true
        default:
            return false
        }
    }
}
