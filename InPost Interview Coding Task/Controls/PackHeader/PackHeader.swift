//
//  PackHeader.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

class PackHeader: UITableViewHeaderFooterView, TableViewHeaderFooter {
    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

private extension PackHeader {
    private func setupView() {
        let leadingDivider = UIView()
        leadingDivider.backgroundColor = .divider
        let trailingDivider = UIView()
        trailingDivider.backgroundColor = .divider

        [leadingDivider, titleLabel, trailingDivider].forEach {
            addSubview($0)
        }

        leadingDivider.activate(
            leadingDivider.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingDivider.heightAnchor.constraint(equalToConstant: 1),
            leadingDivider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leadingDivider.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -20)
        )

        trailingDivider.activate(
            trailingDivider.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingDivider.heightAnchor.constraint(equalToConstant: 1),
            trailingDivider.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            trailingDivider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            trailingDivider.widthAnchor.constraint(equalTo: leadingDivider.widthAnchor)
        )

        titleLabel.activate(
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        )

        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

extension PackHeader {
    func set(title: String) {
        titleLabel.attributedText = .init(text: title, style: .subtitle, alignment: .center)
    }
}

