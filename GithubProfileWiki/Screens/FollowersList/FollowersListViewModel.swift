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

final class FollowersListViewModel {
    var followers: [Follower] = []
    weak var output: FollowersListViewModelOutput?
    var filteredFollowers: [Follower] = []

    private func fetchUserInfo(userName: String, param: [String: Any], completion: @escaping (User?, Error?) -> Void) {
        let request = UserAPI(userName: userName)

        let apiService = APIService(apiRequest: request)
        apiService.submitRequest(requestData: param) { (model, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
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
            let service = FollowersAPI()
            let result = try await service.getFollowers(username: userName)
            self.output?.dismissLoading()
            switch result {
            case .success(let followersResponse):
                self.followers.append(contentsOf: followersResponse)
                self.output?.updateData(on: self.followers)
            case .failure(let error):
                self.output?.displayAlertPopup(title: "Error", message: error.customMessage, buttonTitle: "Tamam")
            }
        }
    }

    func addCurrentUserToFavorites(userName: String) {
        fetchUserInfo(userName: userName, param: [:]) {[weak self] (response, error) in
            self?.output?.dismissLoading()
            if error != nil {
                self?.output?.displayAlertPopup(title: Constants.WarningTexts.errorTitle,
                                                message: error?.localizedDescription ?? Constants.WarningTexts.errorMessage,
                                                buttonTitle: Constants.InfoTexts.closeButtonText)
            } else {
                if let userModel = response {
                    DispatchQueue.main.async {
                        let favoriteUser: Follower = Follower(login: userModel.login, avatarUrl: userModel.avatarUrl)
                        self?.addFavoriteUserToUserDefaults(with: favoriteUser)
                        self?.output?.displayAlertPopup(title: Constants.InfoTexts.success,
                                                      message: Constants.InfoTexts.favorited,
                                                      buttonTitle: Constants.InfoTexts.closeButtonText)
                    }
                }
            }
        }
    }

    func userHasMoreFollower() -> Bool {
        return FollowersAPI.FollowersRequestConstantValues.hasMoreFollower
    }

    func resetPageNumber() {
        FollowersAPI.FollowersRequestConstantValues.pageNum = 1
    }

    func increasePageNumber() {
        FollowersAPI.FollowersRequestConstantValues.pageNum += 1
    }

    func getPageNumber() -> Int {
        return FollowersAPI.FollowersRequestConstantValues.pageNum
    }
}
