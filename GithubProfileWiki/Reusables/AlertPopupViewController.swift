//
//  AlertPopupViewController.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

class AlertPopupViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    let titleLabel = BaseTitleLabel(textAlignment: .center, fontSize: 20, fontWeight: .bold)
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
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTitleView() {
        
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -10)
        ])
    }
    
    private func configureMessageLabel() {
        
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40),
        ])
    }
    
    
    private func configureButton() {
        
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(dismissAlertPopup), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 12),
            button.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func dismissAlertPopup() {
        dismiss(animated: true, completion: nil)
    }
}
