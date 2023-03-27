//
//  FixtureCellViewModelTests.swift
//  EnglishPremierLeagueTests
//
//  Created by Mohamed Abd ElNasser on 27/03/2023.
//

import XCTest
@testable import EnglishPremierLeague

final class FixtureCellViewModelTests: XCTestCase {
    var viewModel: FixtureCellViewModel!

    override func setUp() {
        super.setUp()

        viewModel = FixtureCellViewModel()
    }

    override func tearDown() {
        viewModel = nil

        super.tearDown()
    }

    func testSetupMatch_HomeTeamWinner() {
        // Given
        let homeTeamScore = 4
        let awayTeamScore = 1
        let match = Utils.addNewMatchToSampleData(dayOffset: 0, homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore, winner: .homeTeam)

        // When
        viewModel.setup(with: match)

        // Then
        XCTAssertEqual(viewModel.homeTeamScore, "\(homeTeamScore)")
        XCTAssertEqual(viewModel.homeTeamScoreColor, .green)
        XCTAssertEqual(viewModel.awayTeamScore, "\(awayTeamScore)")
        XCTAssertEqual(viewModel.awayTeamScoreColor, .red)
        XCTAssertEqual(viewModel.status, .finished)
    }

    func testSetupMatch_AwayTeamWinner() {
        // Given
        let homeTeamScore = 2
        let awayTeamScore = 5
        let match = Utils.addNewMatchToSampleData(dayOffset: 0, homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore, winner: .awayTeam)

        // When
        viewModel.setup(with: match)

        // Then
        XCTAssertEqual(viewModel.homeTeamScore, "\(homeTeamScore)")
        XCTAssertEqual(viewModel.homeTeamScoreColor, .red)
        XCTAssertEqual(viewModel.awayTeamScore, "\(awayTeamScore)")
        XCTAssertEqual(viewModel.awayTeamScoreColor, .green)
        XCTAssertEqual(viewModel.status, .finished)
    }
}
