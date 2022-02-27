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
        static let searchPageDefaultSpacing: CGFloat = 50.0
        static let anormousSpacing: CGFloat = 80.0
        
        static let profilePhotoWidthHeight: CGFloat = 100.0
        static let gitHubInfoViewHeight: CGFloat = 120.0
        static let profileHeaderContainerHeight: CGFloat = 200.0
        static let mainLogoHeight: CGFloat = 200.0
        
        static let followerCellImg: CGFloat = 100.0
    }

    struct Font {
        static let headlineFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
        static let bodyFont: UIFont = UIFont.preferredFont(forTextStyle: .body)
        
        static let minimumFontSize: CGFloat = 12.0
        static let mediumFontSize: CGFloat = 20.0
    }

    struct InfoTexts {
        static let textFieldPlaceholder: String = "Enter username."
        static let closeButtonText: String = "Close"
        static let success: String = "Success!"
        
        static let createdAt = "Created at"
        static let followerButtonTitle: String = "Get Followers"
        static let githubProfileText: String = "GitHub Profile"
        
        static let repos: String = "Public Repos"
        static let gists: String = "Public Gists"
        static let followers: String = "Followers"
        static let following: String = "Following"
        
        static let favorited: String = "You have successfully favorited this user."
    }
    
    struct WarningTexts {
        static let errorTitle = "Error"
        static let errorMessage = "An Error occured."
        static let searchPopUpMessage: String = "Please enter a username. We need to know who you are looking for."
    }
    
    enum SFSymbols {
        static let location = "mappin.and.ellipse"
        static let repos = "folder"
        static let gists = "text.alignleft"
        static let followers = "heart"
        static let following = "person.2"
    }
    
    enum PageTitles: String {
        case favorites = "Favorites"
    }
}
