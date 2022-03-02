//
//  BaseBodyLabel.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

class BaseBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configureLabel()
    }

    private func configureLabel() {
        textColor = .secondaryLabel
        font = Constants.Font.bodyFont
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = Constants.Styling.minScaleFactor
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
