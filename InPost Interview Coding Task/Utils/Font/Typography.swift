//
//  Typography.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

enum Typography {
    case headline
    case subheadline
    case overline
    case subtitle
    case button

    var fontName: String {
        switch self {
        case .headline: MontserratFont.bold.rawValue
        case .subheadline: MontserratFont.medium.rawValue
        case .overline: MontserratFont.semiBold.rawValue
        case .subtitle: MontserratFont.semiBold.rawValue
        case .button: MontserratFont.bold.rawValue
        }
    }

    var size: Double {
        switch self {
        case .headline: 15
        case .subheadline: 15
        case .overline: 11
        case .subtitle: 13
        case .button: 12
        }
    }

    var lineHeight: Double {
        switch self {
        case .headline: 24
        case .subheadline: 24
        case .overline: 16
        case .subtitle: 16
        case .button: 16
        }
    }

    var lineSpacing: Double {
        (lineHeight - size) / 2
    }

    var kern: Double {
        0.4
    }
}
