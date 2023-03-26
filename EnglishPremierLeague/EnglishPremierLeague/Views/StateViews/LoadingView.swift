//
//  LoadingView.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.automatic)
            .scaleEffect(4)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
