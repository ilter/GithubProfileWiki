//
//  UIViewController+Extension.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

extension UIViewController {
    func presentAlertPopupOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertPopUp = AlertPopupViewController(title: title, message: message, buttonTitle: buttonTitle)
            
            alertPopUp.modalPresentationStyle = .overFullScreen
            alertPopUp.modalTransitionStyle = .crossDissolve
            self.present(alertPopUp, animated: true)
        }
    }
}
