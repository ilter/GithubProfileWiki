//
//  FavoriteCell.swift
//  GithubProfileWiki
//
//  Created by ilter on 11.02.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseIdentifier = "FavoriteCell"
    private lazy var avatarImageView: BaseImageView = {
        let imageView = BaseImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.configureHeight(height: 60)
        imageView.configureWidth(width: 60)
        return imageView
    }()

    private lazy var userNameLabel: BaseTitleLabel = {
        let label = BaseTitleLabel(textAlignment: .left, fontSize: Constants.Styling.maxSpacing, fontWeight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    func setFavoriteCell(favorite: Follower) {
        userNameLabel.text = favorite.login
        avatarImageView.setImage(from: favorite.avatarUrl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [avatarImageView, userNameLabel].forEach { addSubview($0)}
        accessoryType = .disclosureIndicator

        avatarImageView.configureConstraint(leading: (leadingAnchor, Constants.Styling.defaultSpacing),
                                            centerY: (centerYAnchor, .zero))

        userNameLabel.configureConstraint(leading: (avatarImageView.trailingAnchor, Constants.Styling.maxSpacing),
                                          trailing: (trailingAnchor, -Constants.Styling.defaultSpacing),
                                          centerY: (centerYAnchor, .zero))
    }
}
