//
//  FollowersListViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 20.01.2022.
//

import UIKit

final class FollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String?
    var followerListViewModel = FollowersListViewModel()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        
        guard let username = username else { return }
        getFollowers(username: username)
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
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = username
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    }
    
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let minimumItemSpacesing: CGFloat = 10
        let availableWidth = width - (Constants.Styling.defaultSpacing * 2) - (minimumItemSpacesing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: Constants.Styling.defaultSpacing,
                                               left: Constants.Styling.defaultSpacing,
                                               bottom: Constants.Styling.defaultSpacing,
                                               right: Constants.Styling.defaultSpacing)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 48)
        
        return UICollectionViewFlowLayout()
    }
    
    func getFollowers(username: String) {
        followerListViewModel.fetchFollowers(userName: username, param: [:]) { (model, error) in
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
