//
//  TableViewCell.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

protocol TableViewCell: AnyObject {
    static var reuseIdentifier: String { get }
}

extension TableViewCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
