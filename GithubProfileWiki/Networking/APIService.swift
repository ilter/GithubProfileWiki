//
//  APIService.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

final class APIService<T: APIHandler> {
    let apiRequest: T
    let urlSession: URLSession
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func submitRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, Error?) -> ()) {
        if let urlRequest = apiRequest.submitRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { ( data, response, error) in
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse else {
                    return completionHandler(nil, error)
                }
                DispatchQueue.main.async {
                    do {
                        let parsedResponse = try self.apiRequest.parseResponse(data: data, response: httpResponse)
                        completionHandler(parsedResponse, nil)
                    } catch {
                        completionHandler(nil, error)
                    }
                }
            }.resume()
        }
    }
}
