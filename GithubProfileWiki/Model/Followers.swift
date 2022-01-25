//
//  FollowerModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String?
    var avatarUrl: String?
}

typealias Followers = [Follower]
