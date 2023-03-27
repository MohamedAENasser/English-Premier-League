//
//  ErrorView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import SwiftUI

struct ErrorView: View {
    var error: AppError
    var onTapReTry: () -> Void

    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea(.all)

            VStack {
                Image("Warning-icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 50)

                Text(error.description)
                    .font(.title)
                    .multilineTextAlignment(.center)

                Button {
                    onTapReTry()
                } label: {
                    Label("Try Again", systemImage: "arrow.counterclockwise")
                        .labelStyle(.iconOnly)
                }
                .buttonStyle(.borderless)
                .foregroundColor(.defaultTextColor)
                .scaleEffect(3)
                .padding(.top, 20)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: AppError.failedToLoadData, onTapReTry: {})
    }
}
