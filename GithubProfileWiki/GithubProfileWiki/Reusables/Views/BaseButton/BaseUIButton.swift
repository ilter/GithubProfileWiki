//
// Created by ilter on 19.01.2022.
//

import Foundation
import UIKit

class BaseUIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }

    private func configure() {
        layer.cornerRadius = Constants.Styling.defaultCornerRadius
        titleLabel?.textColor = .white
        titleLabel?.font = Constants.Font.headlineFont
        translatesAutoresizingMaskIntoConstraints = false
    }

    func configureButton(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
}
