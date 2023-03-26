//
//  FixturesView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import SwiftUI
import Moya

struct FixturesView: View {
    @EnvironmentObject private var viewModel: FixturesViewModel
    @State private var shouldShowFavoritesOnly = false

    var filteredMatches: [String: [Match]] {
        var matchesPerDay: [String: [Match]] = [:]
        viewModel.visibleDays.forEach { day in
            matchesPerDay[day] = viewModel.fullMatchesList[day]?.filter {
                (!shouldShowFavoritesOnly || (UserDefaults.favoriteMatchesIdList.contains($0.id)))
            }
        }
        return matchesPerDay
    }

    var body: some View {
        NavigationView {
            List() {
                showFavoritesToggleView
                ForEach(Array(filteredMatches.keys).sorted(by: <), id: \.self) { day in
                    if let matches = filteredMatches[day], !matches.isEmpty {
                        daySectionView(from: day, matches: matches)
                    }
                }
            }
            .refreshable {
                viewModel.loadMoreMatches()
            }
            .background(Color.purple)
            .scrollContentBackground(.hidden)
            .navigationTitle("Premier league")
            .listStyle(.insetGrouped)
        }
        .onAppear {
            viewModel.getMatches()
        }
    }

    var showFavoritesToggleView: some View {
        Toggle(isOn: $shouldShowFavoritesOnly) {
            Text(shouldShowFavoritesOnly ? "Show all matches" : "Show favorites only")
        }
        .tint(.purple)
    }

    func daySectionView(from day: String, matches: [Match]) -> some View {
        Section(header: Text(day)) {
            ForEach(matches) { match in
                FixtureCell(match: match)
            }
        }
    }
}

struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        FixturesView()
            .environmentObject(FixturesViewModel())
    }
}