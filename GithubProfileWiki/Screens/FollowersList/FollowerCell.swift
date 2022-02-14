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
        avatarImgView.setImage(from: follower.avatarUrl)
    }
    
    private func configureUI() {
        [avatarImgView, userNameLabel].forEach { addSubview($0) }
        
        avatarImgView.configureConstraint(top: (contentView.topAnchor, Constants.Styling.minimumSpacing),
                                          bottom: (userNameLabel.topAnchor, -Constants.Styling.minimumSpacing),
                                          leading: (contentView.leadingAnchor, Constants.Styling.minimumSpacing),
                                          trailing: (contentView.trailingAnchor, -Constants.Styling.minimumSpacing))
        
        avatarImgView.configureHeight(height: Constants.Styling.followerCellImg)
        avatarImgView.configureWidth(width: Constants.Styling.followerCellImg)
        
        userNameLabel.configureConstraint(top: (avatarImgView.bottomAnchor, Constants.Styling.defaultSpacing),
                                          bottom: (contentView.bottomAnchor, -Constants.Styling.defaultSpacing),
                                          leading: (contentView.leadingAnchor, Constants.Styling.minimumSpacing),
                                          trailing: (contentView.trailingAnchor, -Constants.Styling.minimumSpacing))
    }
}
