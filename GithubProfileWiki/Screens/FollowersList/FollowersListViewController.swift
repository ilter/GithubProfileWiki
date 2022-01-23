//
//  FollowersListViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 20.01.2022.
//

import UIKit

final class FollowersListViewController: UIViewController {
    var username: String?
    var followerListViewModel = FollowersListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = username
    }
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        followerListViewModel.fetchFollowers(userName: username ?? "", param: [:]) { (model, error) in
            if error != nil {
                self.presentAlertPopupOnMainThread(title: "Error", message: error?.localizedDescription ?? "Hata", buttonTitle: "Close")
            } else {
                if let viewModel = model {
                    print(viewModel)
                }
            }
        }
        
    }
}
