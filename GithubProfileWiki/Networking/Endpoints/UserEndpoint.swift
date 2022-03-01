//
//  UserEndpoint.swift
//  GithubProfileWiki
//
//  Created by ilter on 1.03.2022.
//

import Foundation

enum UserEndpoint {
    case user(userName: String)
}

extension UserEndpoint: Endpoint {
    var path: String {
        switch self {
        case .user(let userName):
            return "users/\(userName)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .user:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .user:
            return [
                NetworkConstants.APIHeaders.defaultContentType: NetworkConstants.APIHeaders.defaultContentTypeValue
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .user:
            return nil
        }
    }

}
