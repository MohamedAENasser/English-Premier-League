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
                Color.backgroundColor.ignoresSafeArea(.all)
                NavigationLink {
                    FixturesView()
                        .environmentObject(viewModel)

                } label: {
                    HStack {
                        Text("Go to matches list!")
                            .font(.title)
                        .tint(.black)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    }
                    .background(Color.darkElementsBackgroundColor)
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
