//
//  GithubInfoViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 6.02.2022.
//

import UIKit

class GithubInfoViewController: UIViewController {
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()

    let firstItemInfoView = GithubItemInfoView()
    let secondItemInfoView = GithubItemInfoView()
    let actionButton = BaseUIButton()

    var user: User?
    weak var delegate: ProfileViewControllerDelegate?

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        setupUI()
        configureConstraints()
        configureActionButton()
    }

}

// MARK: - Configure View

extension GithubInfoViewController {

    private func configureBackgroundView() {
        view.layer.cornerRadius = Constants.Styling.defaultCornerRadius
        view.backgroundColor = .secondarySystemBackground
    }

    private func setupUI() {
        [containerStackView, actionButton].forEach { view.addSubview($0) }
        [firstItemInfoView, secondItemInfoView].forEach { containerStackView.addArrangedSubview($0) }
    }

    private func configureConstraints() {
        containerStackView.configureConstraint(top: (view.topAnchor, Constants.Styling.defaultSpacing),
                                               leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                               trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))

        actionButton.configureConstraint(top: (containerStackView.bottomAnchor, Constants.Styling.defaultSpacing),
                                         bottom: (view.bottomAnchor, -Constants.Styling.defaultSpacing),
                                         leading: (view.leadingAnchor, Constants.Styling.defaultSpacing),
                                         trailing: (view.trailingAnchor, -Constants.Styling.defaultSpacing))
    }

    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    @objc func actionButtonTapped() {
    }
}
