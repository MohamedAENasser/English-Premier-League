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
    @Published var matches: [Match] = []
    private var cancellable: AnyCancellable?

    func getMatches() {
        let provider = MoyaProvider<EnglishLeagueTarget>()

        // Setup publisher
        let publisher = provider.requestPublisher(.matches)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: FixturesResponse.self, decoder: JSONDecoder())
            .map(\.matches)

        // Setup subscriber
        cancellable = publisher
            .sink(receiveCompletion: { completion in

                guard case let .failure(error) = completion else { return }

                print(error) // TODO: Error Handling

            }, receiveValue: { [weak self] response in

                self?.matches = response

            })
    }
}
