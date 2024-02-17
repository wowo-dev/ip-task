//
//  UIFont+Typography.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

extension UIFont {
    convenience init?(typography: Typography) {
        self.init(name: typography.fontName, size: typography.size)
    }
}
