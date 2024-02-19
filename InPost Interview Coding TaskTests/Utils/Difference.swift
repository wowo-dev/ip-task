//
//  Difference.swift
//  InPost Interview Coding TaskTests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation
import Difference
import XCTest

public func XCTAssertEqual<T: Equatable>(
    _ received: @autoclosure () throws -> T,
    _ expected: @autoclosure () throws -> T,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    do {
        let expected = try expected()
        let received = try received()
        XCTAssertTrue(expected == received, "Found difference for \n" + diff(expected, received).joined(separator: ", "), file: file, line: line)
    }
    catch {
        XCTFail("Caught error while testing: \(error)", file: file, line: line)
    }
}
