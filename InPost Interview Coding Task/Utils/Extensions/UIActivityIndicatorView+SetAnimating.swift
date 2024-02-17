//
//  UIActivityIndicatorView+SetAnimating.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

extension UIActivityIndicatorView {
    func setAnimating(_ isAnimating: Bool) {
        if isAnimating {
            startAnimating()
        } else {
            stopAnimating()
        }
    }
}

