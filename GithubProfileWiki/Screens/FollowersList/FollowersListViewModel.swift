//
//  FollowersListViewModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

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

import Foundation

class FollowersListViewModel {
    var followers: [Follower] = []
    weak var output: FollowersListViewModelOutput?
    var filteredFollowers: [Follower] = []
    
    func fetchFollowers(userName: String, param: [String: Any], completion: @escaping (Followers?, Error?) -> ()) {
        let request = FollowersAPI(userName: userName)
        
        let apiService = APIService(apiRequest: request)
        apiService.submitRequest(requestData: param) { (model, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
    
    func fetchUserInfo(userName: String, param: [String: Any], completion: @escaping (User?, Error?) -> ()) {
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
    
    
    func addFavoriteUserToUserDefaults(with user: Follower) {
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
        let queryParams: [String: Any] = [FollowersAPI.FollowersRequestConstantValues.page.rawValue: page,
                                          FollowersAPI.FollowersRequestConstantValues.perPage.rawValue: FollowersAPI.FollowersRequestConstantValues.followersPerPage]
        self.output?.displayLoading()
        fetchFollowers(userName: userName, param: queryParams) { [weak self] (model, error) in
            self?.output?.dismissLoading()
            if error != nil {
                self?.output?.displayAlertPopup(title: "Error", message: error?.localizedDescription ?? "Hata", buttonTitle: "Close")
            } else {
                if let viewModel = model {
                    if viewModel.count == .zero && self?.followers.count == .zero {
                        FollowersAPI.FollowersRequestConstantValues.hasMoreFollower = false
                        FollowersAPI.FollowersRequestConstantValues.pageNum = .zero
                        self?.output?.showFollowersEmpty()
                        return
                    }
                    self?.followers.append(contentsOf: viewModel)
                    self?.output?.updateData(on: self?.followers)
                }
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


