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
            ScrollViewReader { scrollReader in
                List() {
                    ForEach(Array(viewModel.matchesPerDay.keys).sorted(by: <), id: \.self) { day in
                        Section(header: Text(day)) {
                            ForEach(viewModel.matchesPerDay[day] ?? []) { match in
                                FixtureCell(match: match)
                            }
                        }
                    }
                }
                .background(Color.purple)
                .scrollContentBackground(.hidden)
                .navigationTitle("Premier league")
                .listStyle(.insetGrouped)
            }
        }
        .onAppear {
            viewModel.getMatches()

        }
    }
}

struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        FixturesView()
    }
}
