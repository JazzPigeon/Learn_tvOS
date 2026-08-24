//
//  learnUITests.swift
//  learnUITests
//
//  Created by Cindy Michalowski on 8/21/26.
//

import XCTest

final class learnUITests: BaseTest {

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testSample() throws {
        print("Wait here")
    }
}
