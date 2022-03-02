//
//  GithubProfileWikiTests.swift
//  GithubProfileWikiTests
//
//  Created by ilter on 28.02.2022.
//

import XCTest
@testable import GithubProfileWiki

class GithubProfileWikiTests: XCTestCase {
    var user: User!
    var title: String!
    var message: String!
    var buttonTitle: String!

    override func setUp() {
        user = User(login: "",
                    avatarUrl: "",
                    name: "",
                    location: "",
                    bio: "",
                    publicRepos: .zero,
                    publicGists: .zero,
                    htmlUrl: "",
                    following: .zero,
                    followers: .zero,
                    createdAt: "")
        title = ""
        message = ""
        buttonTitle = ""
    }

    override func tearDown() {
        user = nil
        title = nil
        message = nil
        buttonTitle = nil
    }

    func test__itShowsUserFollowersWhenTapped() {
        let viewModel = ProfileViewModel()
        viewModel.output = self
        let mockUser = User(login: "alperenduran",
                            avatarUrl: "https://avatars.githubusercontent.com/u/23004475?v=4",
                            name: "Alperen Duran",
                            location: "Berlin, Germany",
                            bio: nil,
                            publicRepos: 4, publicGists: 0, htmlUrl: "https://github.com/alperenduran",
                            following: 19,
                            followers: 14,
                            createdAt: "2016-10-22T21:17:16Z")
        viewModel.showUserFollowers(for: mockUser)

        XCTAssertEqual(mockUser, self.user)
    }

    func test__FollowersServiceMock() async {
        let serviceMock = FollowersServiceMock()
        do {
            let failingResult = try await serviceMock.getFollowers(username: "ilter", pageNumber: 1)

            switch failingResult {
            case .success(let followers):
                XCTAssertEqual(followers.first?.login, "keremkusmezer")
            case .failure:
                XCTFail("The Followers Service request with ilter param should not fail")
            }
        } catch {
            XCTFail("The Followers Service request should not fail")
        }
    }

    func test__UserServiceMock() async {
        let userServiceMock = UserServiceMock()

        do {
            let failingResult = try await userServiceMock.getUser(userName: "ilter")

            switch failingResult {
            case .success(let user):
                XCTAssertEqual(user.login, "ilter")
                XCTAssertEqual(user.publicRepos, 10)
            case .failure:
                XCTFail("The User Service request with ilter param should not fail")
            }
        } catch {
            XCTFail("The User Service request should not fail")
        }
    }

    func test__FollowersServiceFailure() async {
        let serviceMock = FollowersServiceMock()
        do {
            let failingResult = try await serviceMock.getFollowersError(userName: "ilter", pageNumber: 1)

            switch failingResult {
            case .success(_):
                XCTFail("This case should be fail")
            case .failure(let fail):
                XCTAssertEqual(fail, RequestError.decode)
            }
        } catch {
            XCTFail("The Followers Service request should not fail")
        }
    }

    func test__UserServiceFailure() async {
        let serviceMock = UserServiceMock()
        do {
            let failingResult = try await serviceMock.getUserFailure(userName: "ilter")

            switch failingResult {
            case .success(_):
                XCTFail("This case should be fail")
            case .failure(let fail):
                XCTAssertEqual(fail, RequestError.noResponse)
            }
        } catch {
            XCTFail("The User Service request should not fail")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension GithubProfileWikiTests: ProfileViewModelOutput {
    func displayError(title: String, message: String, buttonTitle: String) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
    }

    func configureUIElements(with user: User) {
        self.user = user
    }

    func showUserFollowers(for user: User) {
        self.user = user
    }
    func showGitHubProfile(for user: User) {
        self.user = user
    }
}

final class FollowersServiceMock: Mockable, FollowersServiceable {
    func getFollowers(username: String, pageNumber: Int) async throws -> Result<Followers, RequestError> {
        return .success(loadJSON(filename: "followers_response", type: Followers.self))
    }

    func getFollowersError(userName: String, pageNumber: Int) async throws -> Result<Followers, RequestError> {
        return .failure(.decode)
    }
}

final class UserServiceMock: Mockable, UserServiceable {
    func getUser(userName: String) async throws -> Result<User, RequestError> {
        return .success(loadJSON(filename: "user_response", type: User.self))
    }

    func getUserFailure(userName: String) async throws -> Result<User, RequestError> {
        return .failure(.noResponse)
    }
}
