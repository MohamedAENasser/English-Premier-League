//
//  FavoriteButton.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 25/03/2023.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            let labelText = isSet ? "Remove from favorites" : "Add to favorites"
            Label(labelText, systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .favoritesColor : .nonSelectedColor)
        }
        .buttonStyle(.borderless)
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
