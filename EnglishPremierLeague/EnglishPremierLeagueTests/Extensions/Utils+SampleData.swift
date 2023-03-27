//
//  Utils+SampleData.swift
//  EnglishPremierLeagueTests
//
//  Created by Mohamed Abd ElNasser on 27/03/2023.
//

import Foundation
@testable import EnglishPremierLeague

extension Utils {

    static func addNewMatchToSampleData(dayOffset: Int, homeTeamScore: Int? = nil, awayTeamScore: Int? = nil, winner: MatchWinner? = nil) {
        sampleData.matches.append(
            Match(
                id: UUID().hashValue,
                awayTeam: Team(id: UUID().hashValue, name: "Away Team Sample"),
                homeTeam: Team(id: UUID().hashValue, name: "Home Team Sample"),
                score: Score(
                    fullTime: TimeModel(awayTeam: awayTeamScore, homeTeam: homeTeamScore),
                    winner: winner?.rawValue),
                status: winner == nil ? MatchStatus.scheduled.rawValue : MatchStatus.finished.rawValue,
                utcDate: stringFromDate(offsetBy: dayOffset)
            )
        )
    }

    static func addNewMatchesArrayToSampleData(offsets: [Int], homeTeamScore: Int? = nil, awayTeamScore: Int? = nil, winner: MatchWinner? = nil) {
        offsets.forEach { dayOffset in
            addNewMatchToSampleData(dayOffset: dayOffset, homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore, winner: winner)
        }
    }

    static func resetSampleData() {
        sampleData.matches = []
    }

    static func stringFromDate(offsetBy offset: Int = 0) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: offset, to: Date()) ?? Date())
    }

    static func shortDateStringFromDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
