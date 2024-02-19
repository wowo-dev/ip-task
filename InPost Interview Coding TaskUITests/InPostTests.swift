//
//  InPostTests.swift
//  InPost Interview Coding TaskUITests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import XCTest

final class DummyTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(true)
    }
}
