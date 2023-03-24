//
//  FixtureCell.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 23/03/2023.
//

import Foundation

import SwiftUI

struct FixtureCell: View {

    let match: Match
    @StateObject private var viewModel = FixtureCellViewModel()

    // UI Properties
    let teamNameFont = Font.body
    let teamScoreFont = Font.body.bold()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                homeTeamView
                awayTeamView
            }
            VStack {
                timeDetailsView
            }
        }
        .contextMenu {
            Button {
                // TODO: Add to favorites logic
            } label: {
                Label("Add to favorites", systemImage: "star")
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
                .padding([.top, .bottom])

            VStack {
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
