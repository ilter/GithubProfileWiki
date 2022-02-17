//
//  ProfileView.swift
//  GithubProfileWiki
//
//  Created by ilter on 17.02.2022.
//

import UIKit

class ProfileView: UIView {
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureHeight(height: Constants.Styling.profileHeaderContainerHeight)
        return view
    }()
    
    let followersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureHeight(height: Constants.Styling.gitHubInfoViewHeight)
        return view
    }()
    
    let reposView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configureHeight(height: Constants.Styling.gitHubInfoViewHeight)
        return view
    }()
    
    let howOldLabel: BaseBodyLabel = BaseBodyLabel(textAlignment: .center)
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [headerView, followersView, reposView, howOldLabel].forEach { addSubview($0)}
        
        headerView.configureConstraint(top: (safeAreaLayoutGuide.topAnchor, .zero),
                                       leading: (leadingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (trailingAnchor, -Constants.Styling.defaultSpacing))
        
        followersView.configureConstraint(top: (headerView.bottomAnchor, Constants.Styling.maxSpacing),
                                          leading: (leadingAnchor, Constants.Styling.defaultSpacing),
                                          trailing: (trailingAnchor, -Constants.Styling.defaultSpacing))
        
        
        reposView.configureConstraint(top: (followersView.bottomAnchor, Constants.Styling.maxSpacing),
                                      leading: (leadingAnchor, Constants.Styling.defaultSpacing),
                                      trailing: (trailingAnchor, -Constants.Styling.defaultSpacing))
        
        howOldLabel.configureConstraint(top: (reposView.bottomAnchor, Constants.Styling.defaultSpacing),
                                        bottom: (safeAreaLayoutGuide.bottomAnchor, -Constants.Styling.maxSpacing),
                                        leading: (leadingAnchor, Constants.Styling.defaultSpacing),
                                        trailing: (trailingAnchor, -Constants.Styling.defaultSpacing))
    }

}
