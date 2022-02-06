//
//  UserInfoHeaderViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 6.02.2022.
//

import UIKit

class UserInfoHeaderViewController: UIViewController {
    
    private lazy var containerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Constants.Styling.defaultSpacing
        return stackView
    }()
    
    private lazy var userIdentityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let avatarImageView: BaseImageView = BaseImageView(frame: .zero)
    private let userNameLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left, fontSize: 24, fontWeight: .bold)
    private let nameLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left, fontSize: 18, fontWeight: .regular)
    private let bioLabel: BaseBodyLabel = BaseBodyLabel(textAlignment: .left)
    
    private var user: User?
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerStackView)
        
        containerStackView.configureConstraint(top: (view.topAnchor, Constants.Styling.defaultSpacing),
                                               bottom: (view.bottomAnchor, .zero),
                                               leading: (view.leadingAnchor, .zero),
                                               trailing: (view.trailingAnchor, .zero))
        
        
        [userNameLabel, nameLabel, bioLabel].forEach {
            userIdentityStackView.addArrangedSubview($0)
        }
        
        [avatarImageView, userIdentityStackView].forEach { containerStackView.addArrangedSubview($0)}
        
        avatarImageView.configureWidth(width: 100)
        avatarImageView.configureHeight(height: 100)
        setupUI()
        
    }
    
    private func setupUI() {
        if let user = user {
            userNameLabel.text = user.login
            nameLabel.text = user.name
            bioLabel.text = user.bio
            avatarImageView.setImage(from: user.avatarUrl)
        }
        
        bioLabel.numberOfLines = 0
    }

}
