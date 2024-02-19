//
//  PackListScreen.swift
//  InPost Interview Coding TaskUITests
//
//  Created by Wojciech Woźniak on 19/02/2024.
//

import Foundation
import XCTest

struct PackListScreen: Screen {
    let app: XCUIApplication

    func waitForErrorState() -> Self {
        let errorInfoText = app.staticTexts["Nie udało się pobrać listy przesyłek"]
        XCTAssertTrue(errorInfoText.exists)
        return self
    }

    func tapRetryButton() -> Self {
        let retryButton = app.buttons["Spróbuj ponownie"]
        XCTAssertTrue(retryButton.exists)
        retryButton.tap()
        return self
    }

    func verifyEmptyList() {
        let errorInfoText = app.staticTexts["Nie śledzisz jeszcze żadnej przesyłki"]
        XCTAssertTrue(errorInfoText.exists)
    }

    func verifyPopulatedList() {
        XCTAssertTrue(app.staticTexts["NR PRZESYŁKI"].exists)
        XCTAssertTrue(app.staticTexts["id_delivered"].exists)

        XCTAssertTrue(app.staticTexts["STATUS"].exists)
        XCTAssertTrue(app.staticTexts["Odebrana"].exists)

        XCTAssertTrue(app.staticTexts["NADAWCA"].exists)
        XCTAssertTrue(app.staticTexts["sender_delivered"].exists)

        XCTAssertTrue(app.staticTexts["ODEBRANA"].exists)
        XCTAssertTrue(app.staticTexts["czw. | 01.01.70 | 01:00"].exists)

        XCTAssertTrue(app.staticTexts["więcej"].exists)
    }
}
