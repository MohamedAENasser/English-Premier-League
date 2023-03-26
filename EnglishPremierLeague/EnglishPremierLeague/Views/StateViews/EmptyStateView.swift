//
//  EmptyStateView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import SwiftUI

struct EmptyStateView: View {
    var type: AppState.EmptyStateType

    var body: some View {
        let labelText = type == .allMatches ?
        " Stay tuned! 🔥 \n\nThere are no available matches in the meantime.":
        "You didn't add matches as a favorite yet.\n\nMark your favorite matches and you'll see them here ⭐️"
        Text(labelText)
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyStateView(type: .allMatches)
            EmptyStateView(type: .favorites)
        }
    }
}
