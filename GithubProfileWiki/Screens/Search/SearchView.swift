//
//  SearchView.swift
//  GithubProfileWiki
//
//  Created by ilter on 27.02.2022.
//

import Foundation
import UIKit

final class SearchView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let userNameTextField = BaseUITextField()
    let searchButton = BaseUIButton(backgroundColor: .systemGreen, title: Constants.InfoTexts.followerButtonTitle)
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configureLogoImageView()
        configureTextField()
        configureSearchButton()
        createDismissKeyboardTapGesture()
    }
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = .githubLogo
        
        logoImageView.configureConstraint(top: (safeAreaLayoutGuide.topAnchor, Constants.Styling.anormousSpacing),
                                          centerX: (centerXAnchor, .zero))
        logoImageView.configureHeight(height: Constants.Styling.mainLogoHeight)
        logoImageView.configureWidth(width: Constants.Styling.mainLogoHeight)
    }
    
    private func configureTextField() {
        addSubview(userNameTextField)
        
        userNameTextField.configureConstraint(top: (logoImageView.bottomAnchor, Constants.Styling.searchPageDefaultSpacing),
                                              leading: (leadingAnchor, Constants.Styling.searchPageDefaultSpacing),
                                              trailing: (trailingAnchor, -Constants.Styling.searchPageDefaultSpacing))
        userNameTextField.configureHeight(height: Constants.Styling.searchPageDefaultSpacing)
    }
    
    private func configureSearchButton() {
        addSubview(searchButton)
        
        searchButton.configureConstraint(bottom: (safeAreaLayoutGuide.bottomAnchor, -Constants.Styling.searchPageDefaultSpacing),
                                         leading: (leadingAnchor, Constants.Styling.searchPageDefaultSpacing),
                                         trailing: (trailingAnchor, -Constants.Styling.searchPageDefaultSpacing))
        searchButton.configureHeight(height: Constants.Styling.searchPageDefaultSpacing)
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tap)
    }

}
