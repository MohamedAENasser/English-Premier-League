//
//  MainMenuView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 27/03/2023.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel = FixturesViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink {
                    FixturesView()
                        .environmentObject(viewModel)

                } label: {
                    HStack {
                        Text("Go to matches list!")
                        .tint(.white)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    }
                    .background(.purple)
                    .clipShape(Capsule())
                    .padding([.leading, .trailing])
                }
            }

        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
