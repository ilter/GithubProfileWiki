//
//  FollowersService.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

protocol FollowersServiceable {
    func getFollowers(username: String) async throws -> Result<Followers, RequestError>
}

struct FollowersAPI: NetworkManager, FollowersServiceable {
    public enum FollowersRequestConstantValues: String {
        static var pageNum: Int = 1
        static var hasMoreFollower: Bool = true
        static var followersPerPage: Int = 30
        case page
        case perPage = "per_page"
    }

    func getFollowers(username: String) async throws -> Result<Followers, RequestError> {
        return try await sendRequest(endpoint: FollowersEndpoint.followers(userName: username), responseModel: Followers.self)
    }
}
