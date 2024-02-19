//
//  OptionalElementTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import XCTest
@testable import InPost_Interview_Coding_Task

final class OptionalElementTests: XCTestCase {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func test_elementValue_withValidData_isDecoded() throws {
        let validJSON =
"""
[
    {
        "id": "16730345345597442248333",
        "status": "READY_TO_PICKUP",
        "sender": "Test sender",
        "expiryDate": "2022-11-29T04:56:07Z",
        "storedDate": "2022-11-29T04:56:07Z",
        "shipmentType": "PARCEL_LOCKER"
    }
]
"""
        let data = validJSON.data(using: .utf8)!
        let result = try jsonDecoder.decode([OptionalElement<Pack>].self, from: data)

        XCTAssertEqual(result.count, 1)
        XCTAssertNotNil(result.first?.value)
    }

    func test_elementsValue_withCorruptedData_isNilled() throws {
        let invalidJSON =
"""
[
    {
        "corrupted_key": "value"
    }
]
"""
        let data = invalidJSON.data(using: .utf8)!
        let result = try jsonDecoder.decode([OptionalElement<Pack>].self, from: data)

        XCTAssertEqual(result.count, 1)
        XCTAssertNil(result.first?.value)
    }
}
