//
//  AlertPopupViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

class AlertPopupViewController: UIViewController {
    
    private enum PopUpConstants {
        static let popUpWidth: CGFloat = 280
        static let popUpHeight: CGFloat = 220
    }
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    let titleLabel = BaseTitleLabel(textAlignment: .center, fontSize: Constants.Font.mediumFontSize, fontWeight: .bold)
    let messageLabel = BaseBodyLabel(textAlignment: .center)
    let button = BaseUIButton(backgroundColor: .systemPink, title: "OK")
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
     
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        [titleLabel, messageLabel, button].compactMap{ containerView.addSubview($0) }
        
        configureContainerView()
        configureTitleView()
        configureMessageLabel()
        configureButton()
    }
}

extension AlertPopupViewController {
    
    private func configureContainerView() {
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = Constants.Styling.maxCornerRadius
        containerView.layer.borderWidth = Constants.Styling.minimumBorderWidth
        containerView.layer.borderColor = UIColor.white.cgColor
    
        containerView.configureConstraint(centerX: (view.centerXAnchor, .zero), centerY: (view.centerYAnchor, .zero))
        containerView.configureWidth(width: PopUpConstants.popUpWidth)
        containerView.configureHeight(height: PopUpConstants.popUpHeight)
    }
    
    private func configureTitleView() {
        titleLabel.text = alertTitle
        
        titleLabel.configureConstraint(top: (containerView.topAnchor, Constants.Styling.maxSpacing),
                                       bottom: (messageLabel.topAnchor, -Constants.Styling.defaultSpacing),
                                       leading: (containerView.leadingAnchor, Constants.Styling.maxSpacing),
                                       trailing: (containerView.trailingAnchor, -Constants.Styling.maxSpacing))
    }
    
    private func configureMessageLabel() {
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        messageLabel.configureConstraint(top: (titleLabel.bottomAnchor, Constants.Styling.minimumSpacing),
                                       bottom: (button.topAnchor, -Constants.Styling.maxSpacing),
                                       leading: (containerView.leadingAnchor, Constants.Styling.maxSpacing),
                                       trailing: (containerView.trailingAnchor, -Constants.Styling.maxSpacing))
    }
    
    
    private func configureButton() {
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(dismissAlertPopup), for: .touchUpInside)
        
        button.configureConstraint(top: (messageLabel.bottomAnchor, Constants.Styling.defaultSpacing),
                                   bottom: (containerView.bottomAnchor, -Constants.Styling.maxSpacing),
                                   leading: (containerView.leadingAnchor, Constants.Styling.maxSpacing),
                                   trailing: (containerView.trailingAnchor, -Constants.Styling.maxSpacing))
    }
    
    @objc private func dismissAlertPopup() {
        dismiss(animated: true, completion: nil)
    }
}
