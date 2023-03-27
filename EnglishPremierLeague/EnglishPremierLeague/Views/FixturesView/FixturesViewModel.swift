//
//  FixturesViewModel.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import Foundation
import Combine

class FixturesViewModel: ObservableObject {
    @Published var state: AppState = .loading
    var fixturesService: FixturesServiceProtocol = FixturesService()

    // MARK: - Helper properties
    var fullMatchesList: [String : [Match]] = [:]
    var visibleDaysStringList: [String] = []
    var fullDaysStringList: [String] = []
    var mostRecentDayIndex: Int = 0
    var loadDaysCount: Int = 1

    /// Get matches data from the backend.
    @MainActor
    func getMatches() async {
        state = .loading
        subscribeForStateChanges()

        let result = await fixturesService.getMatches()
        switch result {
        case .success(let matchesList):
            setupDatesData(from: matchesList)
        case .failure(let error):
            state = .failure(error)
        }
    }

    /// Load more matches from previous days.
    func loadMoreMatches() {
        if mostRecentDayIndex == 0 { return }
        let maxIndex = mostRecentDayIndex
        mostRecentDayIndex = max(mostRecentDayIndex - loadDaysCount, 0)
        state = .update(Array(fullDaysStringList[mostRecentDayIndex..<maxIndex]))
        loadDaysCount = min(loadDaysCount + 1, 7) // increase days loaded every time to facilitate the user loading more days will lower effort, with maximum of week (7 days) per time
    }

    func getFilteredMatches(shouldShowFavoritesOnly: Bool) -> [String: [Match]] {
        let checkingList = shouldShowFavoritesOnly ? fullDaysStringList : visibleDaysStringList // filter on the full list in case of favorites mode, and visible list in case of normal mode.
        var matchesPerDay: [String: [Match]] = [:]
        checkingList.forEach { day in
            let matches = fullMatchesList[day]?.filter {
                (!shouldShowFavoritesOnly || (UserDefaults.favoriteMatchesIdList.contains($0.id)))
            }
            if let matches, !matches.isEmpty {
                matchesPerDay[day] = matches
            }
        }
        return matchesPerDay
    }

    private func subscribeForStateChanges() {
        // Handle state changes
        $state.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in
            }, receiveValue: { [weak self] state in
                guard let self else { return }
                switch state {
                case .success(let array):
                    self.visibleDaysStringList = array
                case .update(let array):
                    self.visibleDaysStringList.append(contentsOf: array)
                default:
                    break
                }
            })
        )
    }

    private func setupDatesData(from matchesList: [Match]) {
        fullMatchesList = Dictionary(grouping: matchesList) { (match) -> String in
            Utils.fixturesDateFormatter.string(from: match.matchDate)
        }

        // Setup Helper properties that will be used later for filtration and load
        fullDaysStringList = Array(fullMatchesList.keys).sorted(by: <)

        // Getting the matches that will be played today or tomorrow, if nothing found then will pickup the most recent upcoming day that has matches.
        let fullDaysDateList = fullDaysStringList.map { Utils.fixturesDateFormatter.date(from: $0) ?? Date() }
        mostRecentDayIndex = fullDaysDateList.firstIndex(where: { Date().daysDifference(from: $0) >= 0 }) ?? 0

        // Setup initial visible matches to be the most recent for today or the nearest upcoming day.
        state = .success(Array(fullDaysStringList[mostRecentDayIndex..<fullDaysStringList.count]))
    }
}
