//
//  ProfileHeaderViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 6.02.2022.
//

import UIKit

class ProfileHeaderViewController: UIViewController {
    
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
        stackView.spacing = Constants.Styling.defaultSpacing
        return stackView
    }()
    
    private let avatarImageView: BaseImageView = BaseImageView(frame: .zero)
    
    private let userNameLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left,
                                                               fontSize: 24,
                                                               fontWeight: .bold)
    
    private let nameLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left,
                                                           fontSize: 18,
                                                           fontWeight: .regular)
    
    private let bioLabel: BaseBodyLabel = BaseBodyLabel(textAlignment: .left)
    
    private lazy var locationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let locationImageView: BaseImageView = BaseImageView(frame: .zero)
    private let locationLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left,
                                                               fontSize: 18,
                                                               fontWeight: .regular)
    
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
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        
        view.addSubview(containerStackView)
        view.addSubview(bioLabel)
        
        [userNameLabel, nameLabel, locationContainer].forEach {
            userIdentityStackView.addArrangedSubview($0)
        }
        [avatarImageView, userIdentityStackView].forEach { containerStackView.addArrangedSubview($0)}
        locationContainer.addSubview(locationImageView)
        locationContainer.addSubview(locationLabel)
        
        if let user = user {
            userNameLabel.text = user.login
            nameLabel.text = user.name
            bioLabel.text = user.bio
            locationLabel.text = user.location
            avatarImageView.setImage(from: user.avatarUrl)
            locationImageView.image = UIImage(systemName: Constants.SFSymbols.location)
        }
        bioLabel.numberOfLines = 2
    }
    
    private func configureConstraints() {
        containerStackView.configureConstraint(top: (view.topAnchor, Constants.Styling.defaultSpacing),
                                               leading: (view.leadingAnchor, .zero),
                                               trailing: (view.trailingAnchor, .zero))
        
        bioLabel.configureConstraint(top: (containerStackView.bottomAnchor, .zero),
                                     bottom: (view.bottomAnchor, .zero),
                                     leading: (view.leadingAnchor, .zero),
                                     trailing: (view.trailingAnchor, .zero))
        
        avatarImageView.configureWidth(width: Constants.Styling.profilePhotoWidthHeight)
        avatarImageView.configureHeight(height: Constants.Styling.profilePhotoWidthHeight)
        
        locationLabel.configureConstraint(leading: (locationImageView.trailingAnchor, Constants.Styling.minimumSpacing))
    }
    
}
