//
//  EnglishPremierLeagueApp.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 21/03/2023.
//

import SwiftUI

@main
struct EnglishPremierLeagueApp: App {
    @StateObject private var viewModel = FixturesViewModel()

    var body: some Scene {
        WindowGroup {
            FixturesView()
                .environmentObject(viewModel)
        }
    }
}
