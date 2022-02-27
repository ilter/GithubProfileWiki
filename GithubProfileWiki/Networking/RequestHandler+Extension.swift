//
//  RequestHandler+Extension.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

extension RequestHandlerProtocol {
    func setQueryParams(parameters: [String: Any], url: URL) -> URL {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

        urlComponents?.queryItems = parameters.compactMap {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        return urlComponents?.url ?? url
    }

    func setDefaultHeaderParams(request: inout URLRequest) {
        request.setValue(NetworkConstants.APIHeaders.defaultContentTypeValue,
                         forHTTPHeaderField: NetworkConstants.APIHeaders.defaultContentType)
    }
}
