//
//  SplashView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 27/03/2023.
//

import SwiftUI

struct SplashView: View {

    @State var isActive: Bool = false

    var progressInterval: ClosedRange<Date> {
        let start = Date()
        let end = start.addingTimeInterval(3)
        return start...end
    }

    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)
            VStack {
                if self.isActive {
                    MainMenuView()
                } else {
                    Spacer()

                    Image("premier-league-english-football")
                        .resizable()
                        .scaledToFit()

                    Spacer()

                    ProgressView(timerInterval: progressInterval, countsDown: false)
                        .progressViewStyle(.linear)
                        .padding()

                    Spacer()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
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
