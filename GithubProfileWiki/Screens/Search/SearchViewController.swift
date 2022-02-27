//
//  SearchViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 17.01.2022.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController {
    
    private let viewSource = SearchView()
    
    override func loadView() {
        view = viewSource
        viewSource.searchButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        viewSource.userNameTextField.delegate = self
    }
    
    private var isUserNameEntered: Bool {
        guard let userName = viewSource.userNameTextField.text else { return false }
        return !userName.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension SearchViewController {
    @objc private func pushFollowersListVC() {
        guard isUserNameEntered,
              let username = viewSource.userNameTextField.text else {
                  presentAlertPopupOnMainThread(title: Constants.InfoTexts.textFieldPlaceholder,
                                                message: Constants.WarningTexts.searchPopUpMessage,
                                                buttonTitle: Constants.InfoTexts.closeButtonText)
                  return
              }
        let followersListViewController = FollowersListViewController(username: username)
        navigationController?.pushViewController(followersListViewController, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
