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
