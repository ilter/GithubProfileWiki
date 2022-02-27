//
//  BaseImageView.swift
//  GithubProfileWiki
//
//  Created by ilter on 25.01.2022.
//

import UIKit
import Kingfisher

class BaseImageView: UIImageView {

    let placeholderImage: UIImage = .githubLogo

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        layer.cornerRadius = Constants.Styling.defaultCornerRadius
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setImage(from urlString: String) {
        kf.setImage(with: URL(string: urlString))
    }
}
