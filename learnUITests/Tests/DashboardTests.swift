//
//  DashboardTests.swift
//  learnUITests
//
//  Created by Cindy Michalowski on 8/21/26.
//

import XCTest

final class DashboardTests: BaseTest {

    func testDashboardDisplayedAsExpectedOnLaunch() throws {
        DashboardScreen()
            .isDisplayedAsExpectedOnLaunch()
    }
}
