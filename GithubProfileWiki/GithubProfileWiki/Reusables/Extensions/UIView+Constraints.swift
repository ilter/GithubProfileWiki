//
//  UIView+Constraints.swift
//  GithubProfileWiki
//
//  Created by ilter on 22.01.2022.
//

import UIKit

extension UIView {

    func configureConstraint(top: (NSLayoutYAxisAnchor, CGFloat)? = nil,
                             bottom: (NSLayoutYAxisAnchor, CGFloat)? = nil,
                             leading: (NSLayoutXAxisAnchor, CGFloat)? = nil,
                             trailing: (NSLayoutXAxisAnchor, CGFloat)? = nil,
                             centerX: (NSLayoutXAxisAnchor, CGFloat)? = nil,
                             centerY: (NSLayoutYAxisAnchor, CGFloat)? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top.0, constant: top.1).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom.0, constant: bottom.1).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading.0, constant: leading.1).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing.0, constant: trailing.1).isActive = true
        }

        if  let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX.0, constant: centerX.1).isActive = true
        }

        if  let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY.0, constant: centerY.1).isActive = true

        }
    }

    func configureWidth(width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func configureHeight(height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func alignFitEdges(insetedBy: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: insetedBy).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -insetedBy).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: insetedBy).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -insetedBy).isActive = true
    }
}
