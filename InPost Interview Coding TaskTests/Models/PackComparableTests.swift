//
//  PackComparableTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import XCTest
@testable import InPost_Interview_Coding_Task

final class PackComparableTests: XCTestCase {
    let oldestDate = Date(timeIntervalSince1970: 0)
    let middleDate = Date(timeIntervalSince1970: 3600)
    let newestDate = Date(timeIntervalSince1970: 7200)

    // MARK: - Comparisons

    func test_comparingPacks_byStatus_areOrderedByPriority() {
        let packs = Pack.Status.allCases.shuffled().map { samplePack($0) }
        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].status, .created)
        XCTAssertEqual(result[1].status, .confirmed)
        XCTAssertEqual(result[2].status, .adoptedAtSourceBranch)
        XCTAssertEqual(result[3].status, .sentFromSourceBranch)
        XCTAssertEqual(result[4].status, .adoptedAtSortingCenter)
        XCTAssertEqual(result[5].status, .sentFromSortingCenter)
        XCTAssertEqual(result[6].status, .other)
        XCTAssertEqual(result[7].status, .delivered)
        XCTAssertEqual(result[8].status, .returnedToSender)
        XCTAssertEqual(result[9].status, .avizo)
        XCTAssertEqual(result[10].status, .outForDelivery)
        XCTAssertEqual(result[11].status, .readyToPickup)
        XCTAssertEqual(result[12].status, .pickupTimeExpired)
    }

    func test_comparingPacks_byPickupDate_areOrderedNewestToOldest() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "oldestPickupDate", pickupDate: oldestDate),
            samplePack(.confirmed, id: "middlePickupDate", pickupDate: middleDate),
            samplePack(.confirmed, id: "newestPickupDate", pickupDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "newestPickupDate")
        XCTAssertEqual(result[1].id, "middlePickupDate")
        XCTAssertEqual(result[2].id, "oldestPickupDate")
    }

    func test_comparingPacks_byExpiryDate_areOrderedNewestToOldest() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "oldestPickupDate", expiryDate: oldestDate),
            samplePack(.confirmed, id: "middlePickupDate", expiryDate: middleDate),
            samplePack(.confirmed, id: "newestPickupDate", expiryDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "newestPickupDate")
        XCTAssertEqual(result[1].id, "middlePickupDate")
        XCTAssertEqual(result[2].id, "oldestPickupDate")
    }

    func test_comparingPacks_byStoredDate_areOrderedNewestToOldest() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "oldestPickupDate", storedDate: oldestDate),
            samplePack(.confirmed, id: "middlePickupDate", storedDate: middleDate),
            samplePack(.confirmed, id: "newestPickupDate", storedDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "newestPickupDate")
        XCTAssertEqual(result[1].id, "middlePickupDate")
        XCTAssertEqual(result[2].id, "oldestPickupDate")
    }

    func test_comparingPacks_byID_areOrderedAscending() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "1"),
            samplePack(.confirmed, id: "sampleID"),
            samplePack(.confirmed, id: "78-numbers-and-text"),
            samplePack(.confirmed, id: "2")
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "1")
        XCTAssertEqual(result[1].id, "2")
        XCTAssertEqual(result[2].id, "78-numbers-and-text")
        XCTAssertEqual(result[3].id, "sampleID")
    }

    // MARK: - Comparators order

    func test_comparingPacks_withDifferentStatuses_areOrderedByStatusPriority() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "1", sender: "", expiryDate: oldestDate, pickupDate: newestDate, storedDate: middleDate),
            samplePack(.other, id: "2", sender: "", expiryDate: middleDate, pickupDate: middleDate, storedDate: oldestDate),
            samplePack(.delivered, id: "3", sender: "", expiryDate: newestDate, pickupDate: oldestDate, storedDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "1")
        XCTAssertEqual(result[1].id, "2")
        XCTAssertEqual(result[2].id, "3")
    }

    func test_comparingPacks_withSameStatus_areOrderedByPickupDate() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "1", sender: "", expiryDate: oldestDate, pickupDate: newestDate, storedDate: middleDate),
            samplePack(.confirmed, id: "2", sender: "", expiryDate: middleDate, pickupDate: middleDate, storedDate: oldestDate),
            samplePack(.confirmed, id: "3", sender: "", expiryDate: newestDate, pickupDate: oldestDate, storedDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "1")
        XCTAssertEqual(result[1].id, "2")
        XCTAssertEqual(result[2].id, "3")
    }

    func test_comparingPacks_withSameStatusAndPickupDate_areOrderedByExpiryDate() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "1", sender: "", expiryDate: oldestDate, storedDate: middleDate),
            samplePack(.confirmed, id: "2", sender: "", expiryDate: middleDate, storedDate: oldestDate),
            samplePack(.confirmed, id: "3", sender: "", expiryDate: newestDate, storedDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "3")
        XCTAssertEqual(result[1].id, "2")
        XCTAssertEqual(result[2].id, "1")
    }

    func test_comparingPacks_withSameStatusPickupAndExpiryDate_areOrderedByStoredDate() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "1", sender: "", storedDate: middleDate),
            samplePack(.confirmed, id: "2", sender: "", storedDate: oldestDate),
            samplePack(.confirmed, id: "3", sender: "", storedDate: newestDate)
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "3")
        XCTAssertEqual(result[1].id, "1")
        XCTAssertEqual(result[2].id, "2")
    }

    func test_comparingPacks_withSameStatusPickupExpiryAndStoredDate_areOrderedByID() {
        let oldestDate = Date(timeIntervalSince1970: 0)
        let middleDate = Date(timeIntervalSince1970: 3600)
        let newestDate = Date(timeIntervalSince1970: 7200)

        let packs: [Pack] = [
            samplePack(.confirmed, id: "1", sender: ""),
            samplePack(.confirmed, id: "2", sender: ""),
            samplePack(.confirmed, id: "3", sender: "")
        ]
            .shuffled()

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].id, "1")
        XCTAssertEqual(result[1].id, "2")
        XCTAssertEqual(result[2].id, "3")
    }

    func test_comparingPacks_withSameAllComparisonProperties_orderIsNotChanged() {
        let packs: [Pack] = [
            samplePack(.confirmed, id: "1", sender: "First Sender"),
            samplePack(.confirmed, id: "1", sender: "Second Sender"),
            samplePack(.confirmed, id: "1", sender: "Third Sender")
        ]

        let result = packs.sorted(by: <)

        XCTAssertEqual(result[0].sender, "First Sender")
        XCTAssertEqual(result[1].sender, "Second Sender")
        XCTAssertEqual(result[2].sender, "Third Sender")
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
