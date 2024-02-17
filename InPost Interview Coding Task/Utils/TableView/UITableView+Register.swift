//
//  UITableView+Register.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

extension UITableView {
    func register(cell: TableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func register(headerFooter: TableViewHeaderFooter.Type) {
        register(headerFooter, forHeaderFooterViewReuseIdentifier: headerFooter.reuseIdentifier)
    }
}
