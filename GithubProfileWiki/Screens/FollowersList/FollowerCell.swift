//
//  FollowerCell.swift
//  GithubProfileWiki
//
//  Created by ilter on 25.01.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseIdentifier = "FollowerCell"
    
    let avatarImgView = BaseImageView(frame: .zero)
    let userNameLabel = BaseTitleLabel(textAlignment: .center, fontSize: 12, fontWeight: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
    }
    
    private func configureUI() {
        [avatarImgView, userNameLabel].forEach { addSubview($0) }
        
        avatarImgView.configureConstraint(top: (contentView.topAnchor, Constants.Styling.minimumSpacing),
                                          bottom: (userNameLabel.topAnchor, -Constants.Styling.minimumSpacing),
                                          leading: (contentView.leadingAnchor, Constants.Styling.minimumSpacing),
                                          trailing: (contentView.trailingAnchor, -Constants.Styling.minimumSpacing))
        
        avatarImgView.configureHeight(height: 64)
        avatarImgView.configureWidth(width: 64)
        
        userNameLabel.configureConstraint(top: (avatarImgView.bottomAnchor, Constants.Styling.defaultSpacing),
                                          leading: (contentView.leadingAnchor, Constants.Styling.minimumSpacing),
                                          trailing: (contentView.trailingAnchor, -Constants.Styling.minimumSpacing))
    }
}
