//
//  FixtureCellViewModel.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 23/03/2023.
//

import SwiftUI
import Moya

class FixtureCellViewModel: ObservableObject {
    private var match: Match?
    @Published var homeTeamScore: String = ""
    @Published var awayTeamScore: String = ""
    @Published var homeTeamScoreColor: Color = .black
    @Published var awayTeamScoreColor: Color = .black
    @Published var status: MatchSatus = .finished
    @Published var matchTime: String = ""

    func setup(with match: Match) {
        self.match = match
        if let homeTeamScoreValue = match.score?.fullTime.homeTeam {
            homeTeamScore = "\(homeTeamScoreValue)"
        }

        if let awayTeamScoreValue = match.score?.fullTime.awayTeam {
            awayTeamScore = "\(awayTeamScoreValue)"
        }

        status = MatchSatus(rawValue: match.status) ?? .finished

        setupMatchTime()
        setupScoresColors()
    }

    private func setupMatchTime() {
        guard let date = match?.matchDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        matchTime = dateFormatter.string(from: date)
    }

    private func setupScoresColors() {
        guard let winner = match?.score?.winner, winner != MatchWinner.draw.rawValue else { return }
        homeTeamScoreColor = match?.score?.winner == MatchWinner.homeTeam.rawValue ? Color.green : Color.red
        awayTeamScoreColor = match?.score?.winner == MatchWinner.awayTeam.rawValue ? Color.green : Color.red
    }
}
