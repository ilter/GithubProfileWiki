//
//  FavoritesViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 17.01.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {

    private lazy var viewModel = FavoritesViewModel()
    private lazy var viewSource = FavoritesView()

    override func loadView() {
        view = viewSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFavorites()
        viewSource.reloadTableViewData()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = Constants.PageTitles.favorites.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
        viewSource.tableView.delegate = self
        viewSource.tableView.dataSource = self
    }
}

// MARK: - UITableView Delegates
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as?  FavoriteCell else {
            return UITableViewCell()
        }
        let favorite = viewModel.favoriteUsers[indexPath.row]
        cell.setFavoriteCell(favorite: favorite)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = viewModel.favoriteUsers[indexPath.row]
        let destVC = FollowersListViewController(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.favoriteUsers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        UserDefaultsManager().setArrayToLocal(key: .favorites, array: viewModel.favoriteUsers)
    }
}
