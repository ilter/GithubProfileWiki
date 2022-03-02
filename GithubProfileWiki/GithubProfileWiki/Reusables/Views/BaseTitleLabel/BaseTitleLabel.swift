//
//  BaseUILabel.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

class BaseTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        configureLabel()
    }

    private func configureLabel() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = Constants.Styling.defaultScaleFactor
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
