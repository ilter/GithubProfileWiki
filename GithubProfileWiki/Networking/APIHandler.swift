//
//  APIHandler.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

protocol RequestHandlerProtocol {
    associatedtype RequestDataType
    func submitRequest(from data: RequestDataType) -> URLRequest?
}

protocol ResponseHandlerProtocol {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

typealias APIHandler = RequestHandlerProtocol & ResponseHandlerProtocol
