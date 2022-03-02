//
//  ProfileViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func didTappedGitHubProfile(for user: User)
    func didTappedGetFollowers(for user: User)
}

class ProfileViewController: UIViewController {
    private let viewSource = ProfileView()
    private var userName: String
    private var viewModel = ProfileViewModel()

    weak var delegate: FollowersListVCDelegate?

    init(user: Follower) {
        self.userName = user.login
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(dismissViewController))

        navigationItem.rightBarButtonItem = doneButton
        viewModel.output = self
        viewModel.loadUserInfo(userName: userName)
    }

    override func loadView() {
        view = viewSource
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    func setHowOldText(createdAt: String) {
        viewSource.howOldLabel.text = "\(Constants.InfoTexts.createdAt) \(createdAt)"
    }

    private func addChildViewController(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }
}

extension ProfileViewController: ProfileViewModelOutput {
    func displayError(title: String, message: String, buttonTitle: String) {
        presentAlertPopupOnMainThread(title: title, message: message, buttonTitle: buttonTitle)
    }

    func configureUIElements(with user: User) {
        let repoViewController = RepoInfoViewController(user: user)
        repoViewController.delegate = self
        let followerInfoViewController = FollowerInfoViewController(user: user)
        followerInfoViewController.delegate = self

        addChildViewController(child: ProfileHeaderViewController(user: user), to: viewSource.headerView)
        addChildViewController(child: repoViewController, to: viewSource.reposView)
        addChildViewController(child: followerInfoViewController, to: viewSource.followersView)
        setHowOldText(createdAt: user.createdAt.convertDateToDisplayFormat())
    }

    func showGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { return }
        presentSafariVC(with: url)
    }

    func showUserFollowers(for user: User) {
        guard user.followers != .zero else {
            presentAlertPopupOnMainThread(title: Constants.WarningTexts.errorTitle,
                                          message: Constants.WarningTexts.errorMessage,
                                          buttonTitle: Constants.InfoTexts.closeButtonText)
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dismissViewController()
    }
}

// MARK: - Delegate

extension ProfileViewController: ProfileViewControllerDelegate {
    func didTappedGitHubProfile(for user: User) {
        viewModel.showGitHubProfile(for: user)
    }

    func didTappedGetFollowers(for user: User) {
        viewModel.showUserFollowers(for: user)
    }
}
