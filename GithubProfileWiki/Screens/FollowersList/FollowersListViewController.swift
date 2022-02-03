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
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
        
        guard let username = username else { return }
        getFollowers(username: username)
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

    func getFollowers(username: String) {
        followerListViewModel.fetchFollowers(userName: username, param: [:]) { [weak self] (model, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.presentAlertPopupOnMainThread(title: "Error", message: error?.localizedDescription ?? "Hata", buttonTitle: "Close")
            } else {
                if let viewModel = model {
                    strongSelf.followers = viewModel
                    strongSelf.updateData()
                }
            }
        }
    }
}

// MARK: - Configure CollectionView

extension FollowersListViewController {
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
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
        
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower ) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell
            cell?.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
