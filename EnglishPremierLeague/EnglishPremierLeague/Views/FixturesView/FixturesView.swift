//
//  FixturesView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 22/03/2023.
//

import SwiftUI
import Moya

struct FixturesView: View {
    @StateObject private var viewModel = FixturesViewModel()

    var body: some View {
        NavigationView {
            List() {
                ForEach(Array(viewModel.visibleDays).sorted(by: <), id: \.self) { day in
                    if let matches = viewModel.fullMatchesList[day], !matches.isEmpty {
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
    }
}
