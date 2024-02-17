//
//  PackCell.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

class PackCell: UITableViewCell, TableViewCell {
    private let packView = PackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func set(pack: Pack) {
        packView.setup(pack: pack)
    }
}

private extension PackCell {
    func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(packView)

        packView.activate(
            packView.topAnchor.constraint(equalTo: contentView.topAnchor),
            packView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            packView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            packView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        )
    }
}