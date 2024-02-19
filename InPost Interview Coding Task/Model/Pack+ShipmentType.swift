//
//  Pack+ShipmentType.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

extension Pack {
    enum ShipmentType: String, Codable, CaseIterable {
        case parcelLocker = "PARCEL_LOCKER"
        case courier = "COURIER"
    }
}
