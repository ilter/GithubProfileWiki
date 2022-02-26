//
//  FavoritesViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 17.01.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var favoriteUsers: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteUsers()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        configureTableView()
    }
    
}

// MARK: - Configure UI Elements
extension FavoritesViewController {
    private func configureTableView() {
        tableView.frame = view.bounds
        tableView.rowHeight = Constants.Styling.maxSpacing * 4
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
    
    private func getFavoriteUsers() {
        let favorites: [Follower] = UserDefaultsManager().getArrayFromLocal(key: .favorites)
        favoriteUsers = favorites
        tableView.reloadData()
    }
}

// MARK: - UITableView Delegates
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as! FavoriteCell
        let favorite = favoriteUsers[indexPath.row]
        cell.setFavoriteCell(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoriteUsers[indexPath.row]
        let destVC = FollowersListViewController(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        favoriteUsers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        UserDefaultsManager().setArrayToLocal(key: .favorites, array: favoriteUsers)
    }
}
