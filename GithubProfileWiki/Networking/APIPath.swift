//
//  APIPath.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct URLPath {
    var environment = Environment()
    var userName: String

    var followersUrl: String {
        return "\(environment.baseUrl)/users/\(userName)/followers"
    }

    var userUrl: String {
        return "\(environment.baseUrl)/users/\(userName)"
    }
}
