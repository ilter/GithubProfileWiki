//
//  ProfileViewModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import Foundation

protocol ProfileViewModelInput: AnyObject {
    func loadUserInfo(userName: String)
    func showGitHubProfile(for user: User)
    func showUserFollowers(for user: User)
}

protocol ProfileViewModelOutput: AnyObject {
    func displayError(title: String, message: String, buttonTitle: String)
    func configureUIElements(with user: User)
    func showUserFollowers(for user: User)
    func showGitHubProfile(for user: User)
}

class ProfileViewModel {
    weak var output: ProfileViewModelOutput?

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

}

extension ProfileViewModel: ProfileViewModelInput {
    func showUserFollowers(for user: User) {
        output?.showUserFollowers(for: user)
    }

    func showGitHubProfile(for user: User) {
        output?.showGitHubProfile(for: user)
    }

    func loadUserInfo(userName: String) {
        fetchUserInfo(userName: userName, param: [:]) { [weak self] (response, error) in
            guard let self = self else { return }
            if error != nil {
                self.output?.displayError(title: Constants.WarningTexts.errorTitle,
                                     message:  error?.localizedDescription ?? Constants.WarningTexts.errorMessage,
                                     buttonTitle: Constants.InfoTexts.closeButtonText)
            } else {
                if let userModel = response {
                        self.output?.configureUIElements(with: userModel)
                }
            }
        }
    }
}
