//
//  FavoritesViewModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 27.02.2022.
//

import Foundation

protocol FavoritesViewModelInput: AnyObject {
    func loadFavorites()
}

protocol FavoritesViewModelOutput: AnyObject {
    func getFavorites() -> [Follower]
}

final class FavoritesViewModel {
    var favoriteUsers: [Follower] = []
}

extension FavoritesViewModel: FavoritesViewModelInput {
    func loadFavorites() {
        let favorites: [Follower] = UserDefaultsManager().getArrayFromLocal(key: .favorites)
        favoriteUsers = favorites
    }
}

extension FavoritesViewModel: FavoritesViewModelOutput {
    func getFavorites() -> [Follower] {
        return favoriteUsers
    }
}
