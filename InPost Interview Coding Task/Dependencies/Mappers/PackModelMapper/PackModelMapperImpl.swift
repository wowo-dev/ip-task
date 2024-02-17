//
//  PackModelMapperImpl.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation
import UIKit

final class PackModelMapperImpl {
    private let dateSeparator = " | "
    private let dateFormatter = DateFormatter()

    init() {
        dateFormatter.locale = .init(identifier: "pl")
        dateFormatter.dateFormat = ["E", "dd.MM.yy", "HH:mm"].joined(separator: dateSeparator)
    }
}

// MARK: - PackModelMapper
extension PackModelMapperImpl: PackModelMapper {
    func map(packs: [Pack]) -> [PackView.Model] {
        packs.map(mapPack)
    }
}

// MARK: - Private
private extension PackModelMapperImpl {
    func mapPack(_ pack: Pack) -> PackView.Model {
        let attributedDate = mapDisplayDate(pack.displayDate)
        let model = PackView.Model(
            id: pack.id,
            status: pack.status.title,
            sender: pack.sender,
            shipmentIconName: pack.shipmentType.iconName,
            dateTitle: pack.displayDateTitle,
            attributedDate: attributedDate
        )
        return model
    }

    func mapDisplayDate(_ displayDate: Date?) -> NSAttributedString? {
        guard let displayDate else {
            return nil
        }

        let formattedDate = dateFormatter.string(from: displayDate)
        let attributedDate = NSAttributedString(text: formattedDate, style: .subheadline)
        let mutableAttributedDate = NSMutableAttributedString(attributedString: attributedDate)

        formattedDate
            .ranges(of: dateSeparator)
            .forEach {
                mutableAttributedDate.addAttribute(.foregroundColor, value: UIColor.dividerText, range: $0)
            }

        return mutableAttributedDate
    }
}

private extension Pack.Status {
    var title: String {
        switch self {
        case .created: "pack_status_created".localized
        case .confirmed: "pack_status_confirmed".localized
        case .adoptedAtSourceBranch: "pack_status_adopted_branch".localized
        case .sentFromSourceBranch: "pack_status_sent_branch".localized
        case .adoptedAtSortingCenter: "pack_status_adopted_center".localized
        case .sentFromSortingCenter: "pack_status_sent_center".localized
        case .other: "pack_status_other".localized
        case .delivered: "pack_status_delivered".localized
        case .returnedToSender: "pack_status_returned_to_sender".localized
        case .avizo: "pack_status_avizo".localized
        case .outForDelivery: "pack_status_for_delivery".localized
        case .readyToPickup: "pack_status_ready_to_pickup".localized
        case .pickupTimeExpired: "pack_status_pickup_expired".localized
        }
    }
}

private extension Pack.ShipmentType {
    var iconName: String {
        switch self {
        case .parcelLocker: "shipment_parcel_locker"
        case .courier: "shipment_courier"
        }
    }
}

private extension Pack {
    var displayDateTitle: String? {
        switch status {
        case .delivered: "pack_view_title_date_delivered".localized
        case .readyToPickup: "pack_view_title_date_ready_to_pickup".localized
        default: nil
        }
    }

    var displayDate: Date? {
        switch status {
        case .delivered: pickupDate
        case .readyToPickup: expiryDate
        default: nil
        }
    }
}
