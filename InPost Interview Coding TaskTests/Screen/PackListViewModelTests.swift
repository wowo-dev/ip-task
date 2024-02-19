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

    // MARK: - Sections

    func test_sections_beforeDataFetch_areEmpty() throws {
        let sut = PackListViewModel()

        XCTAssertEqual(sut.sections.count, 0)
    }

    func test_sections_withEmptyData_areEmpty() async throws {
        networkingMock.getPacksPackReturnValue = []

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.sections.count, 0)
    }

    func test_sections_withNetworkError_areEmpty() async throws {
        networkingMock.getPacksPackThrowableError = NSError(domain: "", code: 0)

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.sections.count, 0)
    }

    func test_sectionTitles_forAllPackGroups_areCorrectAndInOrder() async throws {
        networkingMock.getPacksPackReturnValue = Pack.Status.allCases.map { samplePack($0) }

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.sections.count, 2)
        XCTAssertEqual(sut.sections[0].title, "Gotowe do odbioru")
        XCTAssertEqual(sut.sections[1].title, "Pozostałe")
    }

    func test_packsGrouping_forAllPackStatuses() async throws {
        networkingMock.getPacksPackReturnValue = Pack.Status.allCases.map { samplePack($0) }

        let sut = PackListViewModel()
        await sut.fetchPacks()

        XCTAssertEqual(sut.sections.count, 2)

        XCTAssertEqual(sut.sections[0].packs.count, 2)
        XCTAssertEqual(sut.sections[0].packs[0].status, "Wydana do doręczenia")
        XCTAssertEqual(sut.sections[0].packs[1].status, "Gotowa do odbioru")

        XCTAssertEqual(sut.sections[1].packs.count, 11)
        XCTAssertEqual(sut.sections[1].packs[0].status, "W trakcie przygotowania")
        XCTAssertEqual(sut.sections[1].packs[1].status, "Nadana")
        XCTAssertEqual(sut.sections[1].packs[2].status, "Przyjęta w oddziale")
        XCTAssertEqual(sut.sections[1].packs[3].status, "Wysłana z oddziału")
        XCTAssertEqual(sut.sections[1].packs[4].status, "Przyjęta w sortowni")
        XCTAssertEqual(sut.sections[1].packs[5].status, "Wysłana z sortowni")
        XCTAssertEqual(sut.sections[1].packs[6].status, "Inny")
        XCTAssertEqual(sut.sections[1].packs[7].status, "Odebrana")
        XCTAssertEqual(sut.sections[1].packs[8].status, "Zwrócona do nadawcy")
        XCTAssertEqual(sut.sections[1].packs[9].status, "Awizo")
        XCTAssertEqual(sut.sections[1].packs[10].status, "Upłynął termin odbioru")
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
