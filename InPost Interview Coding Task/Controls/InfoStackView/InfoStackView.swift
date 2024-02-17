//
//  InfoStackView.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import UIKit

final class InfoStackView: UIStackView {
    private let infoLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension InfoStackView {
    func set(title: String) {
        infoLabel.attributedText = .init(text: title, style: .headline)
    }
}

// MARK: - Subviews setup
private extension InfoStackView {
    private func setupView() {
        axis = .vertical
        backgroundColor = .commonBackground
        spacing = 32
        layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
        isLayoutMarginsRelativeArrangement = true

        infoLabel.numberOfLines = 0
        addArrangedSubview(infoLabel)
    }
}
