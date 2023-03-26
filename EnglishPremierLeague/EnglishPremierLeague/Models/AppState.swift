//
//  AppState.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import Foundation

enum AppState: Equatable {
    case loading
    case success([String])
    case update([String])

    static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success(let lhsResult), .success(let rhsResult)), (.update(let lhsResult), .update(let rhsResult)):
            return lhsResult == rhsResult
        default:
            return false
        }
    }
}
