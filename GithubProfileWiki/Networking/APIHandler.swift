//
//  APIHandler.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol RequestHandlerProtocol {
    associatedtype RequestDataType
    func submitRequest(from data: RequestDataType) -> URLRequest?
}

protocol ResponseHandlerProtocol {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

typealias APIHandler = RequestHandlerProtocol & ResponseHandlerProtocol
