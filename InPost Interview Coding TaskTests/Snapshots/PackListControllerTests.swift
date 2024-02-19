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

    // MARK: - Helpers

    func createVC() async throws -> UIViewController {
        let vc = PackListController()
        let nc = IPNavigationController(rootViewController: vc)
        _ = nc.view.snapshotView(afterScreenUpdates: true)
        try await Task.sleep(for: .seconds(0.1))
        return nc
    }
}
