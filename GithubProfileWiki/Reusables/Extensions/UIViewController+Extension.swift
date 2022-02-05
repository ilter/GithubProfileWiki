//
//  UIViewController+Extension.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func presentAlertPopupOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertPopUp = AlertPopupViewController(title: title, message: message, buttonTitle: buttonTitle)
            
            alertPopUp.modalPresentationStyle = .overFullScreen
            alertPopUp.modalTransitionStyle = .crossDissolve
            self.present(alertPopUp, animated: true)
        }
    }
    
    func showLoadingViewWithActivityIndicator() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = .zero
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8}
        
        let activityIndicator: UIActivityIndicatorView = {
            let view = UIActivityIndicatorView(style: .large)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        containerView.addSubview(activityIndicator)
        
        activityIndicator.configureConstraint(centerX: (view.centerXAnchor, .zero),
                                              centerY: (view.centerYAnchor, .zero))
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        // Put it to the main thread because of the closure call on getFollower
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView: EmptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
