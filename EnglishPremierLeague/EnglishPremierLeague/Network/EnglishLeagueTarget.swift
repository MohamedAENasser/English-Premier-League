//
//  EnglishLeague.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import Moya

enum EnglishLeagueTarget {
    static private let apiKey = "API_KEY"

    case matches
}

extension EnglishLeagueTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://api.football-data.org/v2/competitions/2021") ?? URL(string: "")!
    }

    var path: String {
        switch self {

        case .matches:
            return "/matches"

        }
    }

    var method: Moya.Method {
        switch self {

        case .matches:
            return .get

        }
    }

    var task: Moya.Task {
        switch self {

        case .matches:
            return .requestPlain

        }
    }

    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
            "X-Auth-Token": EnglishLeagueTarget.apiKey
        ]
    }
}
