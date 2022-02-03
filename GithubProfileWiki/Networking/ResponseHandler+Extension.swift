//
//  ResponseHandler+Extension.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct ServiceError: Error, Codable {
    let httpStatus: Int
    let message: String
}


extension ResponseHandlerProtocol {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: response.description)
            }
        } catch let jsonError as NSError{
            print(String(describing: jsonError))
            throw ServiceError(httpStatus: response.statusCode, message: jsonError.localizedDescription)
            
        }
    }
}
