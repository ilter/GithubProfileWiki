//
//  SearchViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 17.01.2022.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    private enum ConstraintConstants {
        static let defaultSpacing: CGFloat = 50.0
        static let anormousSpacing: CGFloat = 80.0
    }
    
    private enum LabelConstants {
        static let popupTitle: String = "Enter Username"
        static let popUpMessage: String = "Please enter a username. We need to know who you are looking for."
    }
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let userNameTextField = BaseUITextField()
    let searchButton = BaseUIButton(backgroundColor: .systemGreen, title: Constants.InfoTexts.followerButtonTitle)
    
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
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        
        logoImageView.configureConstraint(top: (view.safeAreaLayoutGuide.topAnchor, ConstraintConstants.anormousSpacing),
                                          centerX: (view.centerXAnchor, .zero))
        logoImageView.configureHeight(height: Constants.Styling.mainLogoHeight)
        logoImageView.configureWidth(width: Constants.Styling.mainLogoHeight)
    }
    
    private func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        userNameTextField.configureConstraint(top: (logoImageView.bottomAnchor, ConstraintConstants.defaultSpacing),
                                              leading: (view.leadingAnchor, ConstraintConstants.defaultSpacing),
                                              trailing: (view.trailingAnchor, -ConstraintConstants.defaultSpacing))
        userNameTextField.configureHeight(height: ConstraintConstants.defaultSpacing)
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        searchButton.configureConstraint(bottom: (view.safeAreaLayoutGuide.bottomAnchor, -ConstraintConstants.defaultSpacing),
                                         leading: (view.leadingAnchor, ConstraintConstants.defaultSpacing),
                                         trailing: (view.trailingAnchor, -ConstraintConstants.defaultSpacing))
        searchButton.configureHeight(height: ConstraintConstants.defaultSpacing)
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func pushFollowersListVC() {
        guard isUserNameEntered else {
            presentAlertPopupOnMainThread(title: LabelConstants.popupTitle,
                                          message: LabelConstants.popUpMessage,
                                          buttonTitle: Constants.InfoTexts.closeButtonText)
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
