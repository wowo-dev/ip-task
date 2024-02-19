// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


@testable import InPost_Interview_Coding_Task






















class PackNetworkingMock: PackNetworking {




    //MARK: - getPacks

    var getPacksPackThrowableError: (any Error)?
    var getPacksPackCallsCount = 0
    var getPacksPackCalled: Bool {
        return getPacksPackCallsCount > 0
    }
    var getPacksPackReturnValue: [Pack]!
    var getPacksPackClosure: (() async throws -> [Pack])?

    func getPacks() async throws -> [Pack] {
        getPacksPackCallsCount += 1
        if let error = getPacksPackThrowableError {
            throw error
        }
        if let getPacksPackClosure = getPacksPackClosure {
            return try await getPacksPackClosure()
        } else {
            return getPacksPackReturnValue
        }
    }


}
