//
//  PackStatusTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import XCTest
@testable import InPost_Interview_Coding_Task

final class PackStatusTests: XCTestCase {
    func test_packStatusOrder() throws {
        let statuses = Pack.Status.allCases.shuffled()
        let result = statuses.sorted(by: { $0.order < $1.order })
        let expected: [Pack.Status] = [
            .created,
            .confirmed,
            .adoptedAtSourceBranch,
            .sentFromSourceBranch,
            .adoptedAtSortingCenter,
            .sentFromSortingCenter,
            .other,
            .delivered,
            .returnedToSender,
            .avizo,
            .outForDelivery,
            .readyToPickup,
            .pickupTimeExpired
        ]

        XCTAssertEqual(result, expected)
    }
}
