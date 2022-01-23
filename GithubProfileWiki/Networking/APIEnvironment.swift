//
//  APIEnvironment.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

enum Environment {
    case development
    case production
    
    func baseUrl() -> String {
        return "https://\(subdomain()).\(domain())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "github.com"
        case .production:
            return "github.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production:
            return "api"
        }
    }
}
