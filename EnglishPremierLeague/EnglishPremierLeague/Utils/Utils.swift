//
//  Utils.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 25/03/2023.
//

import Foundation

enum Utils {
    static var fixturesDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static var sampleData: FixturesResponse<Match> = FixturesResponse<Match>(matches: [])
}
