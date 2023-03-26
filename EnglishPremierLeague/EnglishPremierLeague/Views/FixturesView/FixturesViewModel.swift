//
//  FixturesViewModel.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import Foundation
import Moya
import Combine

class FixturesViewModel: ObservableObject {
    @Published var visibleDays: [String] = []
    private var cancellable: AnyCancellable?

    // MARK: - Helper properties
    var fullMatchesList: [String : [Match]] = [:]
    private var fullDaysStringList: [String] = []
    private var fullDaysDateList: [Date] = []
    private var mostRecentDayIndex: Int = 0
    private var loadDaysCount: Int = 1

    /// Get matches data from the backend.
    func getMatches() {
        let provider = MoyaProvider<EnglishLeagueTarget>()

        // Setup publisher
        let publisher = provider.requestPublisher(.matches)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: FixturesResponse<Match>.self, decoder: JSONDecoder())
            .map(\.matches)

        // Setup subscriber
        cancellable = publisher
            .sink(receiveCompletion: { completion in

                guard case let .failure(error) = completion else { return }
                print(error) // TODO: Error Handling

            }, receiveValue: { [weak self] response in

                self?.setupDatesData(from: response)

            })
    }

    /// Load more matches from previous days.
    func loadMoreMatches() {
        if mostRecentDayIndex == 0 { return }
        let maxIndex = mostRecentDayIndex
        mostRecentDayIndex = max(mostRecentDayIndex - loadDaysCount, 0)
        visibleDays.append(contentsOf: fullDaysStringList[mostRecentDayIndex..<maxIndex])
        loadDaysCount = min(loadDaysCount + 1, 7) // increase days loaded every time to facilitate the user loading more days will lower effort, with maximum of week (7 days) per time
    }

    private func setupDatesData(from matchesList: [Match]) {
        fullMatchesList = Dictionary(grouping: matchesList) { (match) -> String in
            Utils.fixturesDateFormatter.string(from: match.matchDate)
        }

        // Setup Helper properties that will be used later for filtration and load
        fullDaysStringList = Array(fullMatchesList.keys).sorted(by: <)
        fullDaysDateList = fullDaysStringList.map { Utils.fixturesDateFormatter.date(from: $0) ?? Date() }

        setupMostRecentMatchesDay()
        setupInitialVisibleDays()
    }

    /// Getting the matches that will be played today or tomorrow, if nothing found then will pickup the most recent upcoming day that has matches.
    private func setupMostRecentMatchesDay() {
        mostRecentDayIndex = fullDaysDateList.firstIndex(where: { $0 >= Date() }) ?? 0
    }

    /// Setup initial visible matches to be the most recent for today or the nearest upcoming day.
    private func setupInitialVisibleDays() {
        visibleDays = Array(fullDaysStringList[mostRecentDayIndex..<fullDaysStringList.count])
    }
}
