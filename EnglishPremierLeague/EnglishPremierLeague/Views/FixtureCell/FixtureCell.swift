//
//  FixtureCell.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 23/03/2023.
//

import SwiftUI

struct FixtureCell: View {
    @StateObject private var viewModel = FixtureCellViewModel()
    let match: Match

    // UI Properties
    let teamNameFont = Font.body
    let teamScoreFont = Font.body.bold()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                homeTeamView
                awayTeamView
            }
            timeDetailsView
        }
        .contextMenu {
            Button {
                viewModel.isFavorite.toggle()
            } label: {
                let isSet = UserDefaults.favoriteMatchesIdList.contains(match.id)
                let labelText = isSet ? "Remove from favorites" : "Add to favorites"
                Label(labelText, systemImage: isSet ? "star.fill" : "star")
            }
        }
        .onAppear {
            viewModel.setup(with: match)
        }
    }

    var homeTeamView: some View {
        HStack {
            Text(match.homeTeam.name)
                .font(teamNameFont)

            Spacer()

            Text(viewModel.homeTeamScore)
                .font(teamScoreFont)
                .padding(.trailing)
                .foregroundColor(viewModel.homeTeamScoreColor)

        }
        .padding(.bottom, 1)
    }

    var awayTeamView: some View {
        HStack {
            Text(match.awayTeam.name)
                .font(teamNameFont)

            Spacer()

            Text(viewModel.awayTeamScore)
                .font(teamScoreFont)
                .padding(.trailing)
                .foregroundColor(viewModel.awayTeamScoreColor)
        }
    }

    var timeDetailsView: some View {
        HStack {
            Divider()

            VStack {
                FavoriteButton(isSet: $viewModel.isFavorite)

                if viewModel.status == .finished {
                    Text("FT")
                    Text(viewModel.matchTime)
                } else if viewModel.status == .postponed {
                    Text("PPND")
                        .foregroundColor(Color.orange)
                } else {
                    Text(viewModel.matchTime)
                }
            }
        }
    }
}

struct FixtureCell_Previews: PreviewProvider {
    static var previews: some View {
        FixtureCell(match: Match(id: 0, awayTeam: Team(id: 0, name: "Away"), homeTeam: Team(id: 1, name: "Home"), matchDay: 0, score: nil, status: "", utcDate: "nil"))
    }
}
