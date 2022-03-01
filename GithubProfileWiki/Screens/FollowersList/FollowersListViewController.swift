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
    public enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    var username: String!
    private lazy var viewModel = FollowersListViewModel()
    private var isSearching: Bool = false

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)

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

        viewModel.output = self

        viewModel.resetPageNumber()
    }

    @objc func addButtonTapped() {
        viewModel.addCurrentUserToFavorites(userName: username)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFollowers(userName: username, page: viewModel.getPageNumber())
        viewModel.resetPageNumber()
    }

}

// MARK: - Configure CollectionView

extension FollowersListViewController {
    private func configureCollectionView() {
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

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = username
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }

    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
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

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, follower ) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseIdentifier,
                    for: indexPath
                ) as? FollowerCell
                cell?.set(follower: follower)
                return cell
            }
        )
    }
}

// MARK: - CollectionView Delegate

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard viewModel.userHasMoreFollower() else { return }
            viewModel.increasePageNumber()
            let pageNumber = viewModel.getPageNumber()
            viewModel.loadFollowers(userName: username, page: pageNumber)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray: [Follower] = isSearching ? viewModel.filteredFollowers : viewModel.followers
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
        guard let keyword = searchController.searchBar.text,
              !keyword.isEmpty else {
                  return
              }
        isSearching = true
        viewModel.filteredFollowers = viewModel.followers.filter {$0.login.lowercased().contains(keyword.lowercased())}
        viewModel.updateData(on: viewModel.filteredFollowers)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        viewModel.updateData(on: viewModel.followers)
    }
}

// MARK: - FollowersListVCDelegate

extension FollowersListViewController: FollowersListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        viewModel.resetPageNumber()
        viewModel.followers.removeAll()
        viewModel.filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        let pageNumber = viewModel.getPageNumber()
        viewModel.loadFollowers(userName: username, page: pageNumber)
    }
}

extension FollowersListViewController: FollowersListViewModelOutput {
    func displayAlertPopup(title: String, message: String, buttonTitle: String) {
        presentAlertPopupOnMainThread(title: title, message: message, buttonTitle: buttonTitle)
    }

    func displayLoading() {
        showLoadingViewWithActivityIndicator()
    }

    func dismissLoading() {
        dismissLoadingView()
    }

    func updateData(on followers: [Follower]?) {
        guard let followers = followers else {
            return
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    func showFollowersEmpty() {
        DispatchQueue.main.async {
            self.showEmptyStateView(with: "This User does not have any followers.😞", in: self.view)
        }
    }

}
