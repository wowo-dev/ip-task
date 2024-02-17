//
//  View+Anchors.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

extension UIView {
    func activate(_ constraints: NSLayoutConstraint...) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
