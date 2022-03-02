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
    let userService: UserServiceable

    init(userService: UserService = UserService()) {
        self.userService = userService
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
        Task(priority: .background) {
            let result = try await userService.getUser(userName: userName)
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.output?.configureUIElements(with: response)
                }
            case .failure(let error):
                self.output?.displayError(title: Constants.WarningTexts.errorTitle,
                                          message:  error.customMessage,
                                     buttonTitle: Constants.InfoTexts.closeButtonText)
            }
        }
    }
}
