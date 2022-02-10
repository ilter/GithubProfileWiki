//
//  ProfileViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
    
    private var userName: String?
    private var profileViewModel = ProfileViewModel()
    private var user: User?
    private let howOldLabel: BaseBodyLabel = BaseBodyLabel(textAlignment: .center)
    
    init(user: Follower) {
        super.init(nibName: nil, bundle: nil)
        self.userName = user.login
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
        if let userName = userName {
            getUserInfo(user: userName)
        }
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(headerView)
        view.addSubview(followersView)
        view.addSubview(reposView)
        view.addSubview(howOldLabel)
        
        headerView.configureConstraint(top: (view.safeAreaLayoutGuide.topAnchor, .zero),
                                       leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))
        
        followersView.configureConstraint(top: (headerView.bottomAnchor, Constants.Styling.maxSpacing),
                                       leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))
        
        
        reposView.configureConstraint(top: (followersView.bottomAnchor, Constants.Styling.maxSpacing),
                                       leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))
        
        howOldLabel.configureConstraint(top: (reposView.bottomAnchor, Constants.Styling.defaultSpacing),
                                        bottom: (view.safeAreaLayoutGuide.bottomAnchor, -Constants.Styling.maxSpacing),
                                        leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                        trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))
        
        
    }
    
    private func addChildViewController(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func setHowOldText(createdAt: String) {
        howOldLabel.text = "\(Constants.InfoTexts.createdAt) \(createdAt)"
    }
    
    func getUserInfo(user: String) {
        profileViewModel.fetchUserInfo(userName: user, param: [:]) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.presentAlertPopupOnMainThread(title: Constants.InfoTexts.errorTitle,
                                                         message: error?.localizedDescription ?? Constants.InfoTexts.errorMessage,
                                                         buttonTitle: Constants.InfoTexts.closeButtonText)
            } else {
                if let userModel = response {
                    DispatchQueue.main.async {
                        strongSelf.addChildViewController(child: ProfileHeaderViewController(user: userModel), to: strongSelf.headerView)
                        strongSelf.addChildViewController(child: RepoInfoViewController(user: userModel), to: strongSelf.reposView)
                        strongSelf.addChildViewController(child: FollowerInfoViewController(user: userModel), to: strongSelf.followersView)
                        strongSelf.setHowOldText(createdAt: userModel.createdAt.convertDateToDisplayFormat())
                    }
                }
            }
        }
    }
}
