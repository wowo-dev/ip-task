//
//  PackModelMapperImplTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation
import XCTest
@testable import InPost_Interview_Coding_Task

final class PackModelMapperImplTests: XCTestCase {
    let expiryDate = Date(timeIntervalSince1970: 0)
    let pickupDate = Date(timeIntervalSince1970: 86400)
    let packID = "1234"
    let packSender = "Sender"

    func test_packMapping_withStatus_CREATED() {
        let pack = samplePack(.created)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "W trakcie przygotowania",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_CONFIRMED() {
        let pack = samplePack(.confirmed)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Nadana",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_ADOPTED_AT_SOURCE_BRANCH() {
        let pack = samplePack(.adoptedAtSourceBranch)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Przyjęta w oddziale",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_SENT_FROM_SOURCE_BRANCH() {
        let pack = samplePack(.sentFromSourceBranch)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Wysłana z oddziału",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_ADOPTED_AT_SORTING_CENTER() {
        let pack = samplePack(.adoptedAtSortingCenter)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Przyjęta w sortowni",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_SENT_FROM_SORTING_CENTER() {
        let pack = samplePack(.sentFromSortingCenter)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Wysłana z sortowni",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_OTHER() {
        let pack = samplePack(.other)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Inny",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_DELIVERED() {
        let pack = samplePack(.delivered)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Odebrana",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: "ODEBRANA",
            attributedDate: attributedPickupDate()
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_RETURNED_TO_SENDER() {
        let pack = samplePack(.returnedToSender)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Zwrócona do nadawcy",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_AVIZO() {
        let pack = samplePack(.avizo)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Awizo",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_OUT_FOR_DELIVERY() {
        let pack = samplePack(.outForDelivery)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Wydana do doręczenia",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_READY_TO_PICKUP() {
        let pack = samplePack(.readyToPickup)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Gotowa do odbioru",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: "CZEKA NA ODBIÓR DO",
            attributedDate: attributedExpiryDate()
        )

        XCTAssertEqual(expected, result)
    }

    func test_packMapping_withStatus_PICKUP_TIME_EXPIRED() {
        let pack = samplePack(.pickupTimeExpired)

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: [pack]).first

        let expected = PackView.Model(
            id: "1234",
            status: "Upłynął termin odbioru",
            sender: "Sender",
            shipmentIconName: "shipment_parcel_locker",
            dateTitle: nil,
            attributedDate: nil
        )
        XCTAssertEqual(expected, result)
    }

    func test_shipmentIconMapping() {
        let packs = Pack.ShipmentType.allCases.map {
            samplePack(.delivered, shipmentType: $0)
        }

        let sut = PackModelMapperImpl()
        let result = sut.map(packs: packs)

        XCTAssertEqual(result[0].shipmentIconName, "shipment_parcel_locker")
        XCTAssertEqual(result[1].shipmentIconName, "shipment_courier")
    }

    // MARK: - Helpers

    func samplePack(
        _ status: Pack.Status,
        shipmentType: Pack.ShipmentType = .parcelLocker
    ) -> Pack {
        Pack(
            id: packID,
            status: status,
            sender: packSender,
            expiryDate: expiryDate,
            pickupDate: pickupDate,
            storedDate: nil,
            shipmentType: shipmentType
        )
    }

    func attributedExpiryDate() -> NSAttributedString {
        let date = "czw. | 01.01.70 | 01:00"
        let attributed = NSMutableAttributedString(attributedString: NSAttributedString(text: date, style: .subheadline))
        attributed.addAttribute(.foregroundColor, value: UIColor.dividerText, range: NSRange(location: 4, length: 3))
        attributed.addAttribute(.foregroundColor, value: UIColor.dividerText, range: NSRange(location: 15, length: 3))
        return attributed
    }

    func attributedPickupDate() -> NSAttributedString {
        let date = "pt. | 02.01.70 | 01:00"
        let attributed = NSMutableAttributedString(attributedString: NSAttributedString(text: date, style: .subheadline))
        attributed.addAttribute(.foregroundColor, value: UIColor.dividerText, range: NSRange(location: 3, length: 3))
        attributed.addAttribute(.foregroundColor, value: UIColor.dividerText, range: NSRange(location: 14, length: 3))
        return attributed
    }
}

