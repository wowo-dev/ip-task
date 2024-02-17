//
//  TextStyle.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

enum TextStyle {
    case headline
    case subheadline
    case overline
    case subtitle
    case button

    var typography: Typography {
        switch self {
        case .headline: .headline
        case .subheadline: .subheadline
        case .overline: .overline
        case .subtitle: .subtitle
        case .button: .button
        }
    }

    var color: UIColor {
        switch self {
        case .headline, .subheadline, .button: .text
        case .overline: .label
        case .subtitle: .dividerText
        }
    }
}
