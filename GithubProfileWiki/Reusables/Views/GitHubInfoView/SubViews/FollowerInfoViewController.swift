//
//  FollowerInfoViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 10.02.2022.
//

import Foundation

final class FollowerInfoViewController: GithubInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        firstItemInfoView.set(itemInfoType: .followers, withCount: user?.followers ?? .zero)
        secondItemInfoView.set(itemInfoType: .following, withCount: user?.following ?? .zero)
        actionButton.configureButton(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
