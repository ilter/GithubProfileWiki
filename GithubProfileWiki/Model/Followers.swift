//
//  FollowerModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String
}

typealias Followers = [Follower]
