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
    private var followerListViewModel = FollowersListViewModel()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var followers: [Follower] = []
    private var filteredFollowers: [Follower] = []
    private var isSearching: Bool = false
    
    private enum RequestConstantValues: String {
        static var pageNum: Int = 1
        static var hasMoreFollower: Bool = true
        static var followersPerPage: Int = 30
        case page
        case perPage = "per_page"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        
        guard let username = username else { return }
        getFollowers(username: username, page: RequestConstantValues.pageNum)
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

    func getFollowers(username: String, page: Int) {
        let queryParams: [String: Any] = [RequestConstantValues.page.rawValue: page,
                                    RequestConstantValues.perPage.rawValue: RequestConstantValues.followersPerPage]
        showLoadingViewWithActivityIndicator()
        followerListViewModel.fetchFollowers(userName: username, param: queryParams) { [weak self] (model, error) in
            guard let strongSelf = self else { return }
            strongSelf.dismissLoadingView()
            if error != nil {
                strongSelf.presentAlertPopupOnMainThread(title: "Error", message: error?.localizedDescription ?? "Hata", buttonTitle: "Close")
            } else {
                if let viewModel = model {
                    if viewModel.count == .zero {
                        RequestConstantValues.hasMoreFollower = false
                        RequestConstantValues.pageNum = .zero
                        strongSelf.showEmptyStateView(with: "This User does not have any followers.😞", in: strongSelf.view)
                        return
                    }
                    strongSelf.followers.append(contentsOf: viewModel)
                    strongSelf.updateData(on: strongSelf.followers)
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
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        
        collectionView.configureConstraint(top: (view.topAnchor, .zero),
                                           bottom: (view.bottomAnchor, .zero),
                                           leading: (view.safeAreaLayoutGuide.leadingAnchor, .zero),
                                           trailing: (view.safeAreaLayoutGuide.trailingAnchor, .zero))
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
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
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - CollectionView Delegate

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard RequestConstantValues.hasMoreFollower else { return }
            RequestConstantValues.pageNum += 1
            getFollowers(username: username!, page: RequestConstantValues.pageNum)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray: [Follower] = isSearching ? filteredFollowers : followers
        let follower: Follower = activeArray[indexPath.row]
        let destVC = UserInfoViewController(user: follower)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

// MARK: - Search Controller Delegate

extension FollowersListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
              !filter.isEmpty else {
            return
        }
        isSearching = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}
