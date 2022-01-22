//
//  Constants.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

struct Constants {
    struct Styling {
        static let defaultCornerRadius: CGFloat = 10.0
        static let maxCornerRadius: CGFloat = 16.0
        static let minimumBorderWidth: CGFloat = 2.0
        static let defaultScaleFactor: CGFloat = 0.9
        static let minScaleFactor: CGFloat = 0.75
        
        static let maxSpacing: CGFloat = 20.0
        static let minimumSpacing: CGFloat = 8.0
        static let defaultSpacing: CGFloat = 12.0
        
    }
    struct Font {
        static let headlineFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
        static let bodyFont: UIFont = UIFont.preferredFont(forTextStyle: .body)
        
        static let minimumFontSize: CGFloat = 12.0
        static let mediumFontSize: CGFloat = 20.0
    }
    struct InfoTexts {
        static let textFieldPlacehorder: String = "Enter a username."
    }
}
