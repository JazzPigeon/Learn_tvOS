//
//  LaunchPerformanceTests.swift
//  learnUITests
//
//  Created by Cindy Michalowski on 8/26/26.
//

import XCTest

/// Isolated from `BaseTest` so `XCTApplicationLaunchMetric` measures a real launch.
/// `BaseTest.setUpWithError()` already calls `app.launch()`, which would make this
/// metric time a re-launch instead of a cold start.
final class LaunchPerformanceTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
