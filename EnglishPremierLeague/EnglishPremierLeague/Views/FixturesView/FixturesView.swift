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
        ZStack {
            NavigationView {
                List() {
                    ForEach(viewModel.matches) { match in
                        Section(header: Text(match.utcDate)) {
                            FixtureCell(match: match)
                        }
                    }
                }
                .navigationTitle("Premier league")
                .background(
                    Image("premier-league-english-football")
                        .resizable()
                )
            }
            .onAppear {viewModel.getMatches() }
        }
    }
}

struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        FixturesView()
    }
}
