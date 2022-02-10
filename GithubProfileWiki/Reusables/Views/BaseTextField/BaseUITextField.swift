//
//  BaseUITextField.swift
//  GithubProfileWiki
//
//  Created by ilter on 19.01.2022.
//

import UIKit

class BaseUITextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Constants.Styling.defaultCornerRadius
        layer.borderWidth = Constants.Styling.minimumBorderWidth
        layer.borderColor = UIColor.systemGray4.cgColor
        
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = Constants.Font.minimumFontSize
        
        autocorrectionType = .no
        
        placeholder = Constants.InfoTexts.textFieldPlaceholder
        
        returnKeyType = .done
    }
}
