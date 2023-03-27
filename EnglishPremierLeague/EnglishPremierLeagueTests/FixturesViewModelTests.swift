//
//  FixturesViewModelTests.swift
//  EnglishPremierLeagueTests
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import XCTest
import Moya
@testable import EnglishPremierLeague

final class FixturesViewModelTests: XCTestCase {
    var viewModel: FixturesViewModel!

    override func setUp() {
        super.setUp()

        viewModel = FixturesViewModel()
        Utils.resetSampleData()
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    func testGetMatchesSuccessfully() async {
        // Given
        viewModel.fixturesService.provider = MoyaProvider<EnglishLeagueTarget>(stubClosure: MoyaProvider.immediatelyStub)
        /// Matches list:
        /// - yesterday -> 1 match available
        /// - today -> 1 match available
        /// - tomorrow -> 2 matches available
        Utils.addNewMatchesArrayToSampleData(offsets: [-1, 0, 1, 2])

        // When
        await viewModel.getMatches()

        // Then
        // Check the full list of matches was fetched correctly
        XCTAssertEqual(viewModel.fullMatchesList.count, 4)
        XCTAssertEqual(viewModel.fullDaysStringList.count, 4)

        // Check that the most recent day value was calculated properly, the index should be corresponding the index of the match that will be played today.
        XCTAssertEqual(viewModel.mostRecentDayIndex, 1)
        // Check the visible matches are only the ones will be played today and the upcoming ones.
        XCTAssertEqual(viewModel.visibleDaysStringList.count, 3)
        if case let .success(matchesList) = viewModel.state {
            XCTAssertEqual(matchesList, viewModel.visibleDaysStringList)
        } else {
            XCTFail("State wasn't set properly")
        }
        // Check the filtered matches is properly handled for all matches case
        XCTAssertEqual(viewModel.getFilteredMatches(shouldShowFavoritesOnly: false).count, 3)
    }

    func testLoadMoreMatches() async {
        // Given
        viewModel.fixturesService.provider = MoyaProvider<EnglishLeagueTarget>(stubClosure: MoyaProvider.immediatelyStub)
        /// Matches list:
        /// - 3 days before -> 5 matches available
        /// - 2 days before -> 2 matches available
        /// - yesterday -> 3 matches available
        /// - today -> 1 match available
        /// - tomorrow -> 1 match available
        Utils.addNewMatchesArrayToSampleData(offsets: [-3, -3, -3, -3, -3, -2, -2, -1, -1, -1, 0, 1])

        // When
        await viewModel.getMatches()

        // Then
        // Check the visible matches are only the ones will be played today and the upcoming ones.
        XCTAssertEqual(viewModel.mostRecentDayIndex, 3)
        XCTAssertEqual(viewModel.visibleDaysStringList.count, 2)
        if case let .success(matchesList) = viewModel.state {
            XCTAssertEqual(matchesList, viewModel.visibleDaysStringList)
        } else {
            XCTFail("State wasn't set properly, should be `.success` instead of \(viewModel.state)")
        }
        XCTAssertEqual(viewModel.loadDaysCount, 1)

        // When
        viewModel.loadMoreMatches()

        // Then
        // check the most recent previous day is added to the visible list, and the `mostRecentDayIndex` value is updated accordingly.
        XCTAssertEqual(viewModel.mostRecentDayIndex, 2)
        XCTAssertEqual(viewModel.visibleDaysStringList.count, 3)
        XCTAssertEqual(viewModel.loadDaysCount, 2) // The next time user will load, 2 days will be loaded
        if case let .update(updatedList) = viewModel.state {
            XCTAssertEqual(updatedList.count, 1) // 1 day loaded
        } else {
            XCTFail("State wasn't set properly, should be `.updated` instead of \(viewModel.state)")
        }

        // When
        viewModel.loadMoreMatches()

        // Then
        // check the most recent previous 2 day are added to the visible list, and the `mostRecentDayIndex` value is updated accordingly.
        XCTAssertEqual(viewModel.mostRecentDayIndex, 0)
        XCTAssertEqual(viewModel.visibleDaysStringList.count, 5)
        XCTAssertEqual(viewModel.loadDaysCount, 3) // The next time user will load, 3 days will be loaded
        if case let .update(updatedList) = viewModel.state {
            XCTAssertEqual(updatedList.count, 2) // 1 day loaded
        } else {
            XCTFail("State wasn't set properly, should be `.updated` instead of \(viewModel.state)")
        }

        // When
        viewModel.loadMoreMatches()

        // Then
        // Nothing will change as we already loaded the full available list
        XCTAssertEqual(viewModel.mostRecentDayIndex, 0)
        XCTAssertEqual(viewModel.visibleDaysStringList.count, 5)
        XCTAssertEqual(viewModel.loadDaysCount, 3) // the next time user will load, 3 days will be loaded as there was no data loaded
    }

    func testGetFilteredMatches() async {
        // Given
        viewModel.fixturesService.provider = MoyaProvider<EnglishLeagueTarget>(stubClosure: MoyaProvider.immediatelyStub)
        /// Matches list:
        /// - 3 days before -> 1 match available
        /// - 2 days before -> 1 match available
        /// - yesterday -> 1 match available
        /// - today -> 1 match available
        /// - tomorrow -> 1 match available
        /// - after 3 days -> 1 match available
        /// - after 4 days -> 1 match available
        Utils.addNewMatchesArrayToSampleData(offsets: [-3, -2, -1, 0, 1, 3, 4])
        UserDefaults.favoriteMatchesIdList = [
            Utils.sampleData.matches[0].id,
            Utils.sampleData.matches[1].id
        ]

        // When
        await viewModel.getMatches()

        // Then
        if case let .success(matchesList) = viewModel.state {
            XCTAssertEqual(matchesList, viewModel.visibleDaysStringList)
        } else {
            XCTFail("State wasn't set properly")
        }
        // Check filtered matches on normal mode - all matches including non favorites -
        let allFilteredList = viewModel.getFilteredMatches(shouldShowFavoritesOnly: false)
        XCTAssertEqual(allFilteredList.count, 4) // Number of all available matches existing on 4 days, the matches of today and the upcoming days.

        // Check filtered matches on favorites mode
        let favoritesFilteredList = viewModel.getFilteredMatches(shouldShowFavoritesOnly: true)
        XCTAssertEqual(favoritesFilteredList.count, 2) // Number of favorites matches existing on 2 days.
    }
}
