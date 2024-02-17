//
//  NSAttributedString+TextStyle.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

extension NSAttributedString {
    convenience init(text: String, style: TextStyle) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = style.typography.lineSpacing

        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: style.color,
            .kern: style.typography.kern,
            .paragraphStyle: paragraphStyle
        ]

        attributes[.font] = UIFont(typography: style.typography)
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        self.init(attributedString: attributedString)
    }
}
