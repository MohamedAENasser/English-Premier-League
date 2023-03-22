//
//  FixturesResponse.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import Foundation

// MARK: - FixturesResponse
struct FixturesResponse: Codable {
    let matches: [Match]
}

// MARK: - Match
struct Match: Codable {
    let id: Int
    let awayTeam, homeTeam: Team
    let matchDay: Int
    let score: Score?
    let status: String
    let utcDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case awayTeam
        case homeTeam
        case matchDay = "matchday"
        case score
        case status
        case utcDate
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let name: String
}

// MARK: - Score
struct Score: Codable {
    let duration: String
    let extraTime, fullTime, halfTime, penalties: TimeModel
    let winner: String?
}

// MARK: - ExtraTime
struct TimeModel: Codable {
    let awayTeam, homeTeam: Int?
}
