//
//  PackListViewModelTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import XCTest
import Factory
import Combine
@testable import InPost_Interview_Coding_Task

final class PackListViewModelTests: XCTestCase {
    private var networkingMock: PackNetworkingMock!
    private var subscribers = Set<AnyCancellable>()

    override func setUp() {
        networkingMock = PackNetworkingMock()
        subscribers.removeAll()

        Container.shared.packNetworking.register { self.networkingMock! }
    }

    // MARK: - State

    func test_state_beforeDataFetch_equalsLoading() {
        let sut = PackListViewModel()

        XCTAssertEqual(sut.state, .loading)
    }

    func test_state_withEmptyData_equalsEmpty() async {
        networkingMock.getPacksPackReturnValue = []

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.state, .empty)
    }

    func test_state_withNetworkError_equalsError() async {
        networkingMock.getPacksPackThrowableError = NSError(domain: "", code: 0)

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.state, .error)
    }

    func test_state_withValidData_equalsList() async {
        networkingMock.getPacksPackReturnValue = [
            samplePack(.delivered)
        ]

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.state, .list)
    }

    func test_state_forFetchRetry_changesToLoadingThenList() async {
        networkingMock.getPacksPackReturnValue = [
            samplePack(.delivered)
        ]

        let sut = PackListViewModel()
        let expectation = XCTestExpectation(description: "Status changed to `.list`")
        var states = [PackListState]()

        sut.$state
            .dropFirst()
            .sink { state in
                states.append(state)
                if state == .list {
                    expectation.fulfill()
                }
            }
            .store(in: &subscribers)

        await sut.retryFetchPack()
        await fulfillment(of: [expectation])

        XCTAssertEqual(states[0], .loading)
        XCTAssertEqual(states[1], .list)
    }

    // MARK: - Helpers

    func samplePack(
        _ status: Pack.Status,
        id: String = "",
        sender: String = "",
        expiryDate: Date? = nil,
        pickupDate: Date? = nil,
        storedDate: Date? = nil,
        shipmentType: Pack.ShipmentType = .parcelLocker
    ) -> Pack {
        Pack(
            id: id,
            status: status,
            sender: sender,
            expiryDate: expiryDate,
            pickupDate: pickupDate,
            storedDate: storedDate,
            shipmentType: shipmentType
        )
    }
}
