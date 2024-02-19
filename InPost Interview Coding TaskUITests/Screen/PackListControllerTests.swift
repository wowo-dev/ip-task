//
//  PackListControllerTests.swift
//  InPost Interview Coding TaskUITests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation
import XCTest

final class PackListControllerTest: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }

    override func setUp() {
        continueAfterFailure = false
    }

    func test_retry_thenEmptyList() {
        let app = XCUIApplication()
        app.launchArguments.append("-packNetworkingErrorThenEmptyList")
        app.launch()

        PackListScreen(app: app)
            .waitForErrorState()
            .tapRetryButton()
            .verifyEmptyList()
    }

    func test_retry_thenPopulatedList() {
        let app = XCUIApplication()
        app.launchArguments.append("-packNetworkingErrorThenPopulatedList")
        app.launch()

        PackListScreen(app: app)
            .waitForErrorState()
            .tapRetryButton()
            .verifyPopulatedList()
    }
}
