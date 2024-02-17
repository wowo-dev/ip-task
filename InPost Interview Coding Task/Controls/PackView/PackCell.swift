//
//  PackCell.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

class PackCell: UITableViewCell, TableViewCell {
    private let packView = PackView()
    private var bottomConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup(model: PackView.Model, isLast: Bool) {
        packView.setup(model: model)
        print(model.sender, "isLast:", isLast)
        bottomConstraint?.constant = isLast ? 0 : -16
    }
}

private extension PackCell {
    func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(packView)

        let bottomConstraint = packView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        packView.activate(
            packView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomConstraint,
            packView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            packView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        )

        self.bottomConstraint = bottomConstraint
    }
}
