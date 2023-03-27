//
//  SplashView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 27/03/2023.
//

import SwiftUI

struct SplashView: View {

    @State var isActive: Bool = false

    var body: some View {
        VStack {
            if self.isActive {
                MainMenuView()
            } else {
                Spacer()

                Image("premier-league-english-football")
                    .resizable()
                    .scaledToFit()

                Spacer()

                LoadingView()
                    .padding()

                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }

}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
