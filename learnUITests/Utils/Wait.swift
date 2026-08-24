//
//  Wait.swift
//  learn
//
//  Created by Cindy Michalowski on 8/24/26.
//

import XCTest

enum Wait {

    @discardableResult
    static func forElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 3) -> Bool {
        let existsPredicate = NSPredicate(format: "exists = true")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
}
