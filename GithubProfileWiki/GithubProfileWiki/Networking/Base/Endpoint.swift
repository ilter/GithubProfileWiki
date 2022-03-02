//
//  Endpoint.swift
//  GithubProfileWiki
//
//  Created by ilter on 1.03.2022.
//

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.github.com/"
    }
}
