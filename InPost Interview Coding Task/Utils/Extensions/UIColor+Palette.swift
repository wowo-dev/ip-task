//
//  UIColor+Palette.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

extension UIColor {
    static var accent: UIColor {
        color(named: "accent")
    }

    static var commonBackground: UIColor {
        color(named: "common_background")
    }

    static var listBackground: UIColor {
        color(named: "list_background")
    }

    static var text: UIColor {
        color(named: "text")
    }

    static var label: UIColor {
        color(named: "label")
    }

    static var divider: UIColor {
        color(named: "divider")
    }

    static var dividerText: UIColor {
        color(named: "divider_text")
    }

    static var commonShadow: UIColor {
        color(named: "common_shadow")
    }

    private static func color(named name: String) -> UIColor {
        UIColor(named: name) ?? .white
    }
}
