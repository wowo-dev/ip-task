//
//  Container+UITests.swift
//  InPost Interview Coding Task
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation
import Factory

#if DEBUG

extension Container: AutoRegistering {
    public func autoRegister() {
        if ProcessInfo().arguments.contains("-packNetworkingErrorThenEmptyList") {
            packNetworking.register { PackNetworkingUITestsMock(.errorThenEmptyList) }
        }

        if ProcessInfo().arguments.contains("-packNetworkingErrorThenPopulatedList") {
            packNetworking.register { PackNetworkingUITestsMock(.errorThenPopulatedList) }
        }
    }
}

#endif
