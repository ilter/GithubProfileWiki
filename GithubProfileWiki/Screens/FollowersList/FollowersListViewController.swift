//
//  FollowersListViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 20.01.2022.
//

import UIKit

protocol FollowersListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

final class FollowersListViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
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
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
        
        getFollowers(username: username, page: RequestConstantValues.pageNum)
    }
    
    @objc func addButtonTapped() {
        showLoadingViewWithActivityIndicator()
        followerListViewModel.fetchUserInfo(userName: username, param: [:]) {[weak self] (response, error) in
            guard let strongSelf = self else { return }
            strongSelf.dismissLoadingView()
            if error != nil {
                strongSelf.presentAlertPopupOnMainThread(title: Constants.WarningTexts.errorTitle,
                                                         message: error?.localizedDescription ?? Constants.WarningTexts.errorMessage,
                                                         buttonTitle: Constants.InfoTexts.closeButtonText)
            } else {
                if let userModel = response {
                    DispatchQueue.main.async {
                        let favoriteUser: Follower = Follower(login: userModel.login, avatarUrl: userModel.avatarUrl)
                        strongSelf.addFavoriteUserToUserDefaults(with: favoriteUser)
                        strongSelf.presentAlertPopupOnMainThread(title: Constants.InfoTexts.success,
                                                                 message: Constants.InfoTexts.favorited,
                                                                 buttonTitle: Constants.InfoTexts.closeButtonText)
                    }
                }
            }
        }
   
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
                    if viewModel.count == .zero && strongSelf.followers.count == .zero {
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
    
    func addFavoriteUserToUserDefaults(with user: Follower) {
        let userDefaultsManager = UserDefaultsManager()
        var favorites: [Follower] = userDefaultsManager.getArrayFromLocal(key: .favorites)
        favorites.append(user)
        userDefaultsManager.setArrayToLocal(key: .favorites, array: favorites)
    }
    
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
            getFollowers(username: username, page: RequestConstantValues.pageNum)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray: [Follower] = isSearching ? filteredFollowers : followers
        let follower: Follower = activeArray[indexPath.row]
        let destVC = ProfileViewController(user: follower)
        destVC.delegate = self
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

// MARK: - FollowersListVCDelegate

extension FollowersListViewController: FollowersListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        RequestConstantValues.pageNum = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: RequestConstantValues.pageNum)
    }
}
