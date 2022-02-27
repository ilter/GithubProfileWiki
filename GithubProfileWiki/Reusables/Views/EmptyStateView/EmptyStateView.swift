//
//  EmptyStateView.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import UIKit

final class EmptyStateView: UIView {

    private enum StylingConstants {
        static let imageBottom: CGFloat = 40
        static let imageTrailing: CGFloat = 170
        static let awayFromCenter: CGFloat = -150
        static let horizontalPadding: CGFloat = 40

        static let messageLabelHeight: CGFloat = 200
    }

    private let messageLabel = BaseTitleLabel(textAlignment: .center, fontSize: 32, fontWeight: .bold)
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = .emptyStateLogo
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configureUI()
    }

    private func configureUI() {
        [messageLabel, logoImageView].forEach {
            addSubview($0)
        }

        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

        configureConstraints()
    }

    private func configureConstraints() {
        messageLabel.configureConstraint(leading: (leadingAnchor, StylingConstants.horizontalPadding),
                                         trailing: (trailingAnchor, -StylingConstants.horizontalPadding),
                                         centerY: (centerYAnchor, StylingConstants.awayFromCenter))

        messageLabel.configureHeight(height: StylingConstants.messageLabelHeight)

        logoImageView.configureConstraint(bottom: (bottomAnchor, StylingConstants.horizontalPadding),
                                          trailing: (trailingAnchor, StylingConstants.imageTrailing))
        logoImageView.configureHeight(height: 500)
        logoImageView.configureWidth(width: 500)
    }
}
