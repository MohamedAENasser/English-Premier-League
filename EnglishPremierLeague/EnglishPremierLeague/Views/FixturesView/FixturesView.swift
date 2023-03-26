//
//  FixturesView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import SwiftUI

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
                    Task {
                        await viewModel.getMatches()
                    }
                }

            }
        }
        .onAppear {
            Task {
                await viewModel.getMatches()
            }
        }
    }

    var matchesListView: some View {
        VStack {
            showFavoritesToggleView
            List() {
                ForEach(Array(filteredMatches.keys).sorted(by: <), id: \.self) { day in
                    daySectionView(from: day, matches: filteredMatches[day] ?? [])
                }
            }
            .refreshable {
                guard !shouldShowFavoritesOnly else { return }
                viewModel.loadMoreMatches()
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }
        .background(Color.purple)
    }

    var showFavoritesToggleView: some View {
        HStack {
            Spacer()

            HStack {
                Toggle(isOn: $shouldShowFavoritesOnly) {
                    Text(shouldShowFavoritesOnly ? "Show all matches" : "Show favorites only")
                }
                .tint(.purple)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
            .background(Color.white)
            .clipShape(Capsule())
            .padding([.leading, .trailing])

            Spacer()
        }
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
