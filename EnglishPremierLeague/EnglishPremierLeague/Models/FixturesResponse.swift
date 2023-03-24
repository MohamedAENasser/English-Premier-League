//
//  FixturesResponse.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import Foundation

// MARK: - FixturesResponse
struct FixturesResponse<T: Codable>: Codable {
    let matches: [T]
}

// MARK: - Match
struct Match: Codable, Identifiable {
    let id: Int
    let awayTeam, homeTeam: Team
    let matchDay: Int
    let score: Score?
    let status: String
    let utcDate: String
    var matchDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: utcDate) ?? Date()
    }

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

enum MatchSatus: String {
    case scheduled = "SCHEDULED"
    case finished = "FINISHED"
    case postponed = "POSTPONED"
}

enum MatchWinner: String {
    case homeTeam = "HOME_TEAM"
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
}
