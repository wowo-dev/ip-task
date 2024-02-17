//
//  PackView.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

class PackView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var contentContainer: UIView!
    @IBOutlet private var numberTitleLabel: UILabel!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var shipmentTypeImage: UIImageView!
    @IBOutlet private var statusTitleLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var dateTitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var senderTitleLabel: UILabel!
    @IBOutlet private var senderLabel: UILabel!
    @IBOutlet private var moreLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupContainerShadowPath()
    }
}

extension PackView {
    func setup(model: Model) {
        numberLabel.attributedText = .init(text: model.id, style: .subheadline)
        statusLabel.attributedText = .init(text: model.status, style: .headline)
        senderLabel.attributedText = .init(text: model.sender, style: .headline)
        dateTitleLabel.attributedText = .init(text: model.dateTitle ?? "", style: .overline, alignment: .right)
        dateLabel.attributedText = model.attributedDate
        shipmentTypeImage.image = UIImage(named: model.shipmentIconName)
    }
}

// MARK: - Subviews setup
private extension PackView {
    private func setupView() {
        loadView()
        setupTexts()
        setupContainerStyle()
    }

    private func loadView() {
        Bundle.main.loadNibNamed("PackView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func setupContainerStyle() {
        contentContainer.backgroundColor = .commonBackground
        contentContainer.layer.shadowColor = UIColor.commonShadow.cgColor
        contentContainer.layer.shadowRadius = 5
        contentContainer.layer.shadowOffset = .init(width: 0, height: 5)
        contentContainer.layer.shadowOpacity = 0.1
    }

    private func setupContainerShadowPath() {
        guard contentContainer.layer.shadowPath == nil && !bounds.width.isZero && !bounds.height.isZero else {
            return
        }

        contentContainer.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    private func setupTexts() {
        numberTitleLabel.attributedText = .init(text: "pack_view_title_number".localized, style: .overline)
        statusTitleLabel.attributedText = .init(text: "pack_view_title_status".localized, style: .overline)
        senderTitleLabel.attributedText = .init(text: "pack_view_title_sender".localized, style: .overline)
        moreLabel.attributedText = .init(text: "pack_view_label_more".localized, style: .button)
    }
}
