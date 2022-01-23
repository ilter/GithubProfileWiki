//
//  FollowersService.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct FollowersAPI: APIHandler {
    var userName: String
    
    func submitRequest(from param: [String: Any]) -> URLRequest? {
        let urlString = URLPath(userName: userName).followersUrl
        if var url = URL(string: urlString) {
            url = setQueryParams(parameters: param, url: url)
            var urlRequest = URLRequest(url: url)
            setDefaultHeaderParams(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
            return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> Followers {
        return try defaultParseResponse(data: data, response: response)
    }
}
