//
//  RepoInfoViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 10.02.2022.
//

import Foundation

final class RepoInfoViewController: GithubInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        firstItemInfoView.set(itemInfoType: .repos, withCount: user?.publicRepos ?? .zero)
        secondItemInfoView.set(itemInfoType: .gists, withCount: user?.publicGists ?? .zero)
        actionButton.configureButton(backgroundColor: .systemPurple, title: Constants.InfoTexts.githubProfileText)
    }

    override func actionButtonTapped() {
        guard let user = user else { return }
        delegate?.didTappedGitHubProfile(for: user)
    }
}
