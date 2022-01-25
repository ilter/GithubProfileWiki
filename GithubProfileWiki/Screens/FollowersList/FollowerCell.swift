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
    let userNameLabel = BaseTitleLabel(textAlignment: .center, fontSize: 16, fontWeight: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
                                          leading: (contentView.leadingAnchor, Constants.Styling.minimumSpacing),
                                          trailing: (contentView.trailingAnchor, -Constants.Styling.minimumSpacing))
        avatarImgView.configureHeight(height: 44)
        avatarImgView.configureWidth(width: 44)
        
        userNameLabel.configureConstraint(top: (avatarImgView.bottomAnchor, Constants.Styling.defaultSpacing),
                                          leading: (contentView.leadingAnchor, Constants.Styling.minimumSpacing),
                                          trailing: (contentView.trailingAnchor, -Constants.Styling.minimumSpacing))
    }
}
