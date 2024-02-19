//
//  PackNetworkingUITestsMock.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation

#if DEBUG

class PackNetworkingUITestsMock: PackNetworking {
    private let scenario: Scenario

    init(_ scenario: Scenario) {
        self.scenario = scenario
    }
    private var shouldReturnError = true

    func getPacks() async throws -> [Pack] {
        guard !shouldReturnError else {
            shouldReturnError = false
            throw NSError(domain: "", code: 0)
        }

        switch scenario {
        case .errorThenEmptyList:
            return []
        case .errorThenPopulatedList:
            return [
                Pack(
                    id: "id_delivered",
                    status: .delivered,
                    sender: "sender_delivered",
                    expiryDate: nil,
                    pickupDate: Date(timeIntervalSince1970: 0),
                    storedDate: nil,
                    shipmentType: .parcelLocker
                )
            ]
        }
    }

    enum Scenario {
        case errorThenEmptyList
        case errorThenPopulatedList
    }
}

#endif
