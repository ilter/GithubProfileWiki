//
//  UserInfoViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    let headerView: UIView = UIView()
    
    private var userName: String?
    private var userInfoViewModel = UserInfoViewModel()
    private var user: User?
    
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
        //headerView.backgroundColor = .systemPink
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.configureConstraint(top: (view.safeAreaLayoutGuide.topAnchor, .zero),
                                       leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                       trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))
        headerView.configureHeight(height: 120)
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
    
    func getUserInfo(user: String) {
        userInfoViewModel.fetchUserInfo(userName: user, param: [:]) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.presentAlertPopupOnMainThread(title: "Error",
                                                         message: error?.localizedDescription ?? "Hata",
                                                         buttonTitle: "Close")
            } else {
                if let userModel = response {
                    DispatchQueue.main.async {
                        strongSelf.addChildViewController(child: UserInfoHeaderViewController(user: userModel), to: strongSelf.headerView)
                    }
                }
            }
        }
    }
}
