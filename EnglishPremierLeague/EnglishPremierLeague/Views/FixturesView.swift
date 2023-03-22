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
                List(viewModel.matches, id: \.id) { match in
                    Text(match.homeTeam.name)
                }
                .navigationTitle("Premier league")
                .background(
                    Image("premier-league-english-football")
                        .resizable()
                )
            }

            .onAppear {viewModel.getMatches() }
        }
        .padding()
    }
}

struct FixturesView_Previews: PreviewProvider {
    static var previews: some View {
        FixturesView()
    }
}
