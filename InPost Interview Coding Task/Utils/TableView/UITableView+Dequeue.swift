//
//  UITableView+Dequeue.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

import UIKit

extension UITableView {
    func dequeue(cell: TableViewCell.Type, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
    }

    func dequeue(headerFooter: TableViewHeaderFooter.Type) -> UITableViewHeaderFooterView? {
        dequeueReusableHeaderFooterView(withIdentifier: headerFooter.reuseIdentifier)
    }
}
