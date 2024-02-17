//
//  PackModelMapperImpl.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

final class PackModelMapperImpl {
    private let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateFormat = "E | dd.MM.yy | HH:mm"
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
        let displayDateTitle = pack.displayDateTitle
        var formattedDate: String?

        if let displayDate = pack.displayDate {
            formattedDate = dateFormatter.string(from: displayDate)
        }

        let model = PackView.Model(
            id: pack.id,
            status: pack.status.title,
            sender: pack.sender,
            shipmentIconName: pack.shipmentType.iconName,
            dateTitle: displayDateTitle,
            date: formattedDate
        )
        return model
    }
}

private extension Pack.Status {
    var title: String {
        switch self {
        case .created: "W trakcie przygotowania"
        case .confirmed: "Nadana"
        case .adoptedAtSourceBranch: "Przyjęta w oddziale"
        case .sentFromSourceBranch: "Wysłana z oddziału"
        case .adoptedAtSortingCenter: "Przyjęta w sortowni"
        case .sentFromSortingCenter: "Wysłana z sortowni"
        case .other: "Inny"
        case .delivered: "Odebrana"
        case .returnedToSender: "Zwrócona do nadawcy"
        case .avizo: "Awizo"
        case .outForDelivery: "Wydana do doręczenia"
        case .readyToPickup: "Gotowa do odbioru"
        case .pickupTimeExpired: "Upłynął termin odbioru"
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
        case .delivered: "ODEBRANA"
        case .readyToPickup: "CZEKA NA ODBIÓR DO"
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
