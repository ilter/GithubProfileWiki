//
//  FollowersService.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

protocol FollowersServiceable {
    func getFollowers(username: String, pageNumber: Int) async throws -> Result<Followers, RequestError>
}

struct FollowersAPI: NetworkManager, FollowersServiceable {
    func getFollowers(username: String, pageNumber: Int) async throws -> Result<Followers, RequestError> {
        return try await sendRequest(endpoint: FollowersEndpoint.followers(userName: username, pageNumber: pageNumber), responseModel: Followers.self)
    }
}
