//
//  FollowersEndpoint.swift
//  GithubProfileWiki
//
//  Created by ilter on 1.03.2022.
//

import Foundation

enum FollowersEndpoint {
    case followers(userName: String, pageNumber: Int = 1)
}

extension FollowersEndpoint: Endpoint {
    public enum FollowersRequestConstantValues: String {
        static var hasMoreFollower: Bool = true
        static var followersPerPage: String = "30"
        case page
        case perPage = "per_page"
    }

    var path: String {
        switch self {
        case .followers(let userName, let pagenumber):
            return "users/\(userName)/followers?\(FollowersRequestConstantValues.page.rawValue)=\(pagenumber)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .followers:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        // let accessToken = "insert your access token here"
        switch self {
        case .followers:
            return [
                // "Authorization": "Bearer \(accessToken)",
                NetworkConstants.APIHeaders.defaultContentType: NetworkConstants.APIHeaders.defaultContentTypeValue
            ]
        }
    }
    var body: [String: String]? {
        switch self {
        case .followers:
            return nil
        }
    }
}
