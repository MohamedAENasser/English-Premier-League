//
//  FixturesService.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import Foundation
import Moya

protocol FixturesServiceProtocol {
    var provider: MoyaProvider<EnglishLeagueTarget> { get set }
    func getMatches() async -> Result<[Match], AppError>
}

final class FixturesService: FixturesServiceProtocol {
    var provider: MoyaProvider<EnglishLeagueTarget>

    init(provider: MoyaProvider<EnglishLeagueTarget> = MoyaProvider<EnglishLeagueTarget>()) {
        self.provider = provider
    }

    func getMatches() async -> Result<[Match], AppError> {
        return await withCheckedContinuation { continuation in
            provider.request(.matches) { result in
                switch result {
                case .success(let response):
                    do {
                        try continuation.resume(returning: .success(response.map(FixturesResponse.self).matches))
                    } catch {
                        return continuation.resume(returning: .failure(.failedToLoadData))
                    }
                case .failure:
                    return continuation.resume(returning: .failure(.failedToLoadData))
                }
            }
        }
    }
}
