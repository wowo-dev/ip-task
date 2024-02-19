//
//  PackListControllerTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation
import XCTest
import Factory
import SnapshotTesting
@testable import InPost_Interview_Coding_Task

@MainActor
final class PackListControllerTest: XCTestCase {
    private var networkingMock: PackNetworkingMock!

    override func setUp() {
        networkingMock = PackNetworkingMock()
        Container.shared.packNetworking.register { self.networkingMock! }
    }

    func test_packList_emptyState() async throws {
        networkingMock.getPacksPackReturnValue = []

        let vc = try await createVC()
        assertSnapshot(of: vc, as: .image, record: false)
    }

    func test_packList_errorState() async throws {
        networkingMock.getPacksPackThrowableError = NSError(domain: "", code: 0)

        let vc = try await createVC()
        assertSnapshot(of: vc, as: .image, record: false)
    }

    func test_packList_listState() async throws {
        let date = Date(timeIntervalSince1970: 0)
        networkingMock.getPacksPackReturnValue = [
            Pack(id: "1", status: .outForDelivery, sender: "Sender", expiryDate: nil, pickupDate: nil, storedDate: nil, shipmentType: .courier),
            Pack(id: "2", status: .readyToPickup, sender: "Sender", expiryDate: date, pickupDate: nil, storedDate: nil, shipmentType: .parcelLocker),
            Pack(id: "3", status: .delivered, sender: "Sender", expiryDate: nil, pickupDate: date, storedDate: nil, shipmentType: .parcelLocker),
        ]

        let vc = try await createVC()
        assertSnapshot(of: vc, as: .image, record: false)
    }

    // MARK: - Helpers

    func createVC() async throws -> UIViewController {
        let vc = PackListController()
        let nc = IPNavigationController(rootViewController: vc)
        _ = nc.view.snapshotView(afterScreenUpdates: true)
        try await Task.sleep(for: .seconds(0.1))
        return nc
    }
}
