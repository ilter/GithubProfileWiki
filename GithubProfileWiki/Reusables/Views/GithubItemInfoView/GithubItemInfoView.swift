//
//  GithubItemInfoView.swift
//  GithubProfileWiki
//
//  Created by ilter on 6.02.2022.
//

import UIKit

class GithubItemInfoView: UIView {
    
    enum ItemInfoType {
        case repos, gists, followers, following
    }
    
    private let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        return imageView
    }()
    
    private let titleLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left, fontSize: 14, fontWeight: .regular)
    private let countLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .center, fontSize: 14, fontWeight: .regular)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [symbolImageView, titleLabel, countLabel].forEach { addSubview($0) }
        
        symbolImageView.configureConstraint(top: (topAnchor, .zero),
                                            leading: (leadingAnchor, .zero))
        
        titleLabel.configureConstraint(leading: (symbolImageView.trailingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (trailingAnchor, .zero),
                                       centerY: (symbolImageView.centerYAnchor, .zero))
        
        countLabel.configureConstraint(top: (symbolImageView.bottomAnchor, Constants.Styling.minScaleFactor),
                                       bottom: (bottomAnchor, .zero),
                                       centerX: (centerXAnchor, .zero))
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
}
