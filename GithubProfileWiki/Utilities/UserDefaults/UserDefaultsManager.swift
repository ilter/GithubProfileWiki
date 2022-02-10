//
//  UserDefaultsManager.swift
//  GithubProfileWiki
//
//  Created by ilter on 10.02.2022.
//

import Foundation

enum UserDefaultsKeys: String {
    case favorites
}

final class UserDefaultsManager {
    @UserDefaultsHelper(key: UserDefaultsKeys.favorites.rawValue)
    var favorites: [Follower]?
    
    func setArrayToLocal<T: Codable>(key: UserDefaultsKeys, array: [T]) {
        guard let encode = try? JSONEncoder().encode(array) else { return }
        let userDefaults = UserDefaults.standard
        userDefaults.set(encode, forKey: key.rawValue)
    }
    
    func getArrayFromLocal<T: Codable>(key: UserDefaultsKeys) -> [T] {
        let userDefaults = UserDefaults.standard
        guard let encode = userDefaults.data(forKey: key.rawValue),
              let decode = try? JSONDecoder().decode([T].self, from: encode) else { return []}
        
        return decode
    }
    
    func removeFavorites() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.favorites.rawValue)
    }
}
