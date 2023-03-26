//
//  FixtureCellViewModel.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 23/03/2023.
//

import SwiftUI
import Moya
import Combine

class FixtureCellViewModel: ObservableObject {
    private var match: Match?
    @Published var homeTeamScore: String = ""
    @Published var awayTeamScore: String = ""
    @Published var homeTeamScoreColor: Color = .black
    @Published var awayTeamScoreColor: Color = .black
    @Published var status: MatchStatus = .finished
    @Published var matchTime: String = ""
    @Published var isFavorite: Bool = false

    func setup(with match: Match) {
        self.match = match
        if let homeTeamScoreValue = match.score?.fullTime.homeTeam {
            homeTeamScore = "\(homeTeamScoreValue)"
        }

        if let awayTeamScoreValue = match.score?.fullTime.awayTeam {
            awayTeamScore = "\(awayTeamScoreValue)"
        }

        status = MatchStatus(rawValue: match.status) ?? .finished

        setupMatchTime()
        setupScoresColors()
        isFavorite = UserDefaults.favoriteMatchesIdList.contains(match.id)
        $isFavorite.subscribe(Subscribers.Sink(receiveCompletion: { _ in }, receiveValue: toggleFavorites(isFavorite:)))
    }

    private func toggleFavorites(isFavorite: Bool) {
        let matchId = match?.id ?? 0
        if isFavorite, !UserDefaults.favoriteMatchesIdList.contains(matchId) {
            UserDefaults.favoriteMatchesIdList.append(matchId)
        } else if !isFavorite, let index = UserDefaults.favoriteMatchesIdList.firstIndex(where: { $0 == matchId }) {
            UserDefaults.favoriteMatchesIdList.remove(at: index)
        }
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
