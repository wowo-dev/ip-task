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
    
    func setup(model: Model) {
        numberLabel.attributedText = .init(text: model.id, style: .subheadline)
        statusLabel.attributedText = .init(text: model.status, style: .headline)
        senderLabel.attributedText = .init(text: model.sender, style: .headline)
        dateTitleLabel.attributedText = .init(text: model.dateTitle ?? "", style: .overline, alignment: .right)
        dateLabel.attributedText = model.attributedDate
        shipmentTypeImage.image = UIImage(named: model.shipmentIconName)
    }
    
    private func setupView() {
        loadView()
        setupContainerStyle()
        setupTexts()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed("PackView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupContainerStyle() {
        // TODO: Look out for shadow performance?
        contentContainer.backgroundColor = .commonBackground
        contentContainer.layer.shadowColor = UIColor.black.cgColor
        contentContainer.layer.shadowRadius = 5
        contentContainer.layer.shadowOffset = .init(width: 0, height: 5)
        contentContainer.layer.shadowOpacity = 0.1
    }
    
    private func setupTexts() {
        numberTitleLabel.attributedText = .init(text: "NR PRZESYŁKI", style: .overline)
        statusTitleLabel.attributedText = .init(text: "STATUS", style: .overline)
        senderTitleLabel.attributedText = .init(text: "NADAWCA", style: .overline)
        moreLabel.attributedText = .init(text: "więcej", style: .button)
    }
}
