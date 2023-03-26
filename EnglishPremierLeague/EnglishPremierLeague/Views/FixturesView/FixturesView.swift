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
        viewModel.getFilteredMatches(shouldShowFavoritesOnly: shouldShowFavoritesOnly)
    }

    var body: some View {
        ZStack {
            //MARK: - Handle App States
            switch viewModel.state {

            case .success, .update:

                NavigationView {
                    ZStack {
                        matchesListView
                        if filteredMatches.isEmpty {
                            EmptyStateView(type: shouldShowFavoritesOnly ? .favorites : .allMatches)
                            Spacer()
                        }
                    }
                    .navigationTitle("Premier league")
                }

            case .loading:

                LoadingView()

            case .failure(let error):

                ErrorView(error: error) {
                    viewModel.getMatches()
                }

            }
        }
        .onAppear {
            viewModel.getMatches()
        }
    }

    var matchesListView: some View {
        List() {
            showFavoritesToggleView
            ForEach(Array(filteredMatches.keys).sorted(by: <), id: \.self) { day in
                daySectionView(from: day, matches: filteredMatches[day] ?? [])
            }
        }
        .refreshable {
            guard !shouldShowFavoritesOnly else { return }
            viewModel.loadMoreMatches()
        }
        .background(Color.purple)
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
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
