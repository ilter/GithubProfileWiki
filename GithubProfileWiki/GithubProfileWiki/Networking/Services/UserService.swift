//
//  UserService.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import Foundation

protocol UserServiceable {
    func getUser(userName: String) async throws -> Result<User, RequestError>
}

struct UserService: NetworkManager, UserServiceable {
    func getUser(userName: String) async throws -> Result<User, RequestError> {
        return try await sendRequest(endpoint: UserEndpoint.user(userName: userName), responseModel: User.self)
    }
}
