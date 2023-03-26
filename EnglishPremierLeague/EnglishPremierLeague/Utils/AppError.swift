//
//  AppError.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import Foundation

enum AppError: Error {
    case failedToLoadData

    var description: String {
        switch self {
        case .failedToLoadData:
            return "We couldn't load your data\n please try again"
        }
    }
}
