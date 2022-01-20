//
//  SearchViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 17.01.2022.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let userNameTextField = BaseUITextField()
    let searchButton = BaseUIButton(backgroundColor: .systemGreen, title: "GetFollowers")
    
    var isUserNameEntered: Bool {
        guard let userName = userNameTextField.text else { return false }
        return !userName.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        configureLogoImageView()
        configureTextField()
        configureSearchButton()
        createDismissKeyboardTapGesture()
    }
}

extension SearchViewController {
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = .githubLogo
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant:50)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func pushFollowersListVC() {
        guard isUserNameEntered else {
            print("No Username")
            return
        }
        let followersListViewController = FollowersListViewController()
        followersListViewController.username = userNameTextField.text
        navigationController?.pushViewController(followersListViewController, animated: true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
