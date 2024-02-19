//
//  Pack+Comparable.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation

extension Pack: Comparable {
    static func < (lhs: Pack, rhs: Pack) -> Bool {
        let comparators: [(Pack, Pack) -> Bool] = [
            { $0.status.order < $1.status.order },
            { $0.pickupDate ?? .distantFuture > $1.pickupDate ?? .distantFuture },
            { $0.expiryDate ?? .distantFuture > $1.expiryDate ?? .distantFuture },
            { $0.storedDate ?? .distantFuture > $1.storedDate ?? .distantFuture },
            { $0.id.localizedStandardCompare($1.id) == .orderedAscending }
        ]

        for comparator in comparators {
            if !comparator(lhs, rhs) && !comparator(rhs, lhs) {
                continue
            }
            return comparator(lhs, rhs)
        }

        return false
    }
}
