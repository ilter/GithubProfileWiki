//
//  FollowersEndpoint.swift
//  GithubProfileWiki
//
//  Created by ilter on 1.03.2022.
//

import Foundation

enum FollowersEndpoint {
    case followers(userName: String)
}

extension FollowersEndpoint: Endpoint {
    var path: String {
        switch self {
        case .followers(let userName):
            return "users/\(userName)/followers"
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
