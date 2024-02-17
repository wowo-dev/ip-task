//
//  TableViewItem.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

protocol TableViewItem: AnyObject {
    static var reuseIdentifier: String { get }
}

extension TableViewItem {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
