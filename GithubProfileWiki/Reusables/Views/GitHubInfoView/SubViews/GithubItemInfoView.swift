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
    
    private let titleLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .left, fontSize: 14, fontWeight: .semibold)
    private let countLabel: BaseTitleLabel = BaseTitleLabel(textAlignment: .center, fontSize: 14, fontWeight: .semibold)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [symbolImageView, titleLabel, countLabel].forEach { addSubview($0) }
        
        symbolImageView.configureConstraint(top: (topAnchor, .zero),
                                            leading: (leadingAnchor, .zero))
        
        titleLabel.configureConstraint(leading: (symbolImageView.trailingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (trailingAnchor, -Constants.Styling.defaultSpacing),
                                       centerY: (symbolImageView.centerYAnchor, .zero))
        
        countLabel.configureConstraint(top: (symbolImageView.bottomAnchor, Constants.Styling.minimumSpacing),
                                       bottom: (bottomAnchor, .zero),
                                       centerX: (centerXAnchor, .zero))
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.repos)
            titleLabel.text = Constants.InfoTexts.repos
        case .gists:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.gists)
            titleLabel.text = Constants.InfoTexts.gists
        case .followers:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.followers)
            titleLabel.text = Constants.InfoTexts.followers
        case .following:
            symbolImageView.image = UIImage(systemName: Constants.SFSymbols.following)
            titleLabel.text = Constants.InfoTexts.following
        }
        
        countLabel.text = String(count)
    }
}
