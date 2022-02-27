//
//  User.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import Foundation

struct User: Codable, Hashable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
