//
//  FavoritesView.swift
//  GithubProfileWiki
//
//  Created by ilter on 27.02.2022.
//

import Foundation
import UIKit

final class FavoritesView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        tableView.alignFitEdges()
        tableView.rowHeight = Constants.Styling.maxSpacing * 4
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
    
    func showEmptyStateView(with message: String) {
        let emptyStateView: EmptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = bounds
        addSubview(emptyStateView)
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
