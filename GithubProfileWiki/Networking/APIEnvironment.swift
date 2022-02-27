//
//  APIEnvironment.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct Environment {

    var method: String {
        "https://"
    }

    var domain: String {
        "github.com"
    }

    var subdomain: String {
        "api"
    }

    var baseUrl: String {
        "\(method)\(subdomain).\(domain)"
    }
}
