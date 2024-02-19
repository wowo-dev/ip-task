//
//  Pack+Status.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 17/02/2024.
//

import Foundation

/**
 * List of possible statuses with priority order.
 * 1. CREATED
 * 2. CONFIRMED
 * 3. ADOPTED_AT_SOURCE_BRANCH
 * 4. SENT_FROM_SOURCE_BRANCH
 * 5. ADOPTED_AT_SORTING_CENTER
 * 6. SENT_FROM_SORTING_CENTER
 * 7. OTHER
 * 8. DELIVERED
 * 9. RETURNED_TO_SENDER
 * 10. AVIZO
 * 11. OUT_FOR_DELIVERY
 * 12. READY_TO_PICKUP
 * 13. PICKUP_TIME_EXPIRED
 */

extension Pack {
    enum Status: String, Codable, CaseIterable {
        case created = "CREATED"
        case confirmed = "CONFIRMED"
        case adoptedAtSourceBranch = "ADOPTED_AT_SOURCE_BRANCH"
        case sentFromSourceBranch = "SENT_FROM_SOURCE_BRANCH"
        case adoptedAtSortingCenter = "ADOPTED_AT_SORTING_CENTER"
        case sentFromSortingCenter = "SENT_FROM_SORTING_CENTER"
        case other = "OTHER"
        case delivered = "DELIVERED"
        case returnedToSender = "RETURNED_TO_SENDER"
        case avizo = "AVIZO"
        case outForDelivery = "OUT_FOR_DELIVERY"
        case readyToPickup = "READY_TO_PICKUP"
        case pickupTimeExpired = "PICKUP_TIME_EXPIRED"

        /// The order indicator of given ``Status``. Statuses with the highest priorities comes first.
        var order: Int {
            Self.allCases.firstIndex(of: self) ?? 0
        }
    }
}
