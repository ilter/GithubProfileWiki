//
//  FollowersListViewModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

protocol FollowersListViewModelInput: AnyObject {
    func loadFollowers(userName: String, page: Int)
    func addCurrentUserToFavorites(userName: String)
    func userHasMoreFollower() -> Bool
    func resetPageNumber()
    func increasePageNumber()
    func getPageNumber() -> Int
    func updateData(on followers: [Follower]?)
}

protocol FollowersListViewModelOutput: AnyObject {
    func displayAlertPopup(title: String, message: String, buttonTitle: String)
    func displayLoading()
    func dismissLoading()
    func updateData(on followers: [Follower]?)
    func showFollowersEmpty()

}

private enum FollowersListConstants {
    static var hasMoreFollower: Bool = true
    static var pageNumber: Int = 1
}

final class FollowersListViewModel {
    var followers: [Follower] = []
    weak var output: FollowersListViewModelOutput?
    var filteredFollowers: [Follower] = []
    let followersService: FollowersServiceable
    let userService: UserServiceable

    init(service: FollowersServiceable = FollowersService(),
         userService: UserServiceable = UserService()) {
        self.followersService = service
        self.userService = userService
    }

    private func addFavoriteUserToUserDefaults(with user: Follower) {
        let userDefaultsManager = UserDefaultsManager()
        var favorites: [Follower] = userDefaultsManager.getArrayFromLocal(key: .favorites)
        favorites.append(user)
        userDefaultsManager.setArrayToLocal(key: .favorites, array: favorites)
    }
}

extension FollowersListViewModel: FollowersListViewModelInput {

    func updateData(on followers: [Follower]?) {
        output?.updateData(on: followers)
    }

    func loadFollowers(userName: String, page: Int) {
        self.output?.displayLoading()
        Task(priority: .background) {
            self.output?.dismissLoading()
            let result = try await followersService.getFollowers(username: userName, pageNumber: page)
            switch result {
            case .success(let followersResponse):
                if followersResponse.isEmpty && self.followers.isEmpty {
                        self.output?.showFollowersEmpty()
                }
                self.followers.append(contentsOf: followersResponse)
                self.output?.updateData(on: self.followers)
            case .failure(let error):
                self.output?.displayAlertPopup(title: "Error", message: error.customMessage, buttonTitle: "Tamam")
            }
        }
    }

    func addCurrentUserToFavorites(userName: String) {
        Task(priority: .background) {
            let result = try await userService.getUser(userName: userName)
            switch result {
            case .success(let response):
                let favoriteUser: Follower = Follower(login: response.login, avatarUrl: response.avatarUrl)
                addFavoriteUserToUserDefaults(with: favoriteUser)
                self.output?.displayAlertPopup(title: Constants.InfoTexts.success,
                                              message: Constants.InfoTexts.favorited,
                                              buttonTitle: Constants.InfoTexts.closeButtonText)
            case .failure(let error):
                self.output?.displayAlertPopup(title: Constants.WarningTexts.errorTitle,
                                                message: error.customMessage,
                                                buttonTitle: Constants.InfoTexts.closeButtonText)
            }
        }
    }

    func userHasMoreFollower() -> Bool {
        return FollowersListConstants.hasMoreFollower
    }

    func resetPageNumber() {
        FollowersListConstants.pageNumber = 1
    }

    func increasePageNumber() {
        FollowersListConstants.pageNumber += 1
    }

    func getPageNumber() -> Int {
       return FollowersListConstants.pageNumber
    }
}
