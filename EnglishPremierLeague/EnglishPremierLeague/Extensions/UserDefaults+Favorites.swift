//
//  UserDefaults+Favorites.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 26/03/2023.
//

import Foundation

extension UserDefaults {
    static var favoriteMatchesIdList: [Int] {
        get {
            UserDefaults.standard.object(forKey: "favoriteMatchesIdList_Key") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "favoriteMatchesIdList_Key")
        }
    }
}
