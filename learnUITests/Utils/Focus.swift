//
//  Focus.swift
//  learn
//
//  Created by Cindy Michalowski on 8/24/26.
//

import XCTest

enum Focus {

    private static var app: XCUIApplication { XCUIApplication() }

    /// The element that currently holds focus, whatever it happens to be.
    static var current: XCUIElement {
        app.descendants(matching: .any)
            .matching(NSPredicate(format: "hasFocus == true"))
            .firstMatch
    }

    static func hasFocus(_ element: XCUIElement) -> Bool {
        element.hasFocus
    }

    /// True when `container` is focused, or when anything inside it is.
    /// A container never reports `hasFocus` itself, so it has to be derived
    /// from the descendants.
    static func focusedElementIsWithin(_ container: XCUIElement) -> Bool {
        if container.hasFocus { return true }

        return container.descendants(matching: .any)
            .matching(NSPredicate(format: "hasFocus == true"))
            .firstMatch
            .exists
    }

    /// Geometry-based version of `isWithin`, for when SwiftUI flattens the
    /// accessibility tree and the focused element is therefore not a
    /// descendant of the container being asked about.
    static func isWithinFrame(of container: XCUIElement) -> Bool {
        let focused = current
        guard container.exists, focused.exists else { return false }

        let midPoint = CGPoint(x: focused.frame.midX, y: focused.frame.midY)
        return container.frame.contains(midPoint)
    }

    /// The focused element's attributes, for discovering how a screen is
    /// actually structured.
    static func describeCurrent() -> String {
        current.exists ? current.debugDescription : "Nothing is focused"
    }

    // TODO: Decide if I want to keep this
    @discardableResult
    static func waitFor(_ element: XCUIElement, timeout: TimeInterval = 3) -> Bool {
        let focusPredicate = NSPredicate(format: "hasFocus == true")
        let expectation = XCTNSPredicateExpectation(predicate: focusPredicate, object: element)

        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        return result == .completed
    }

    /// Presses `direction` on the remote until `element` takes focus.
    @discardableResult
    static func move(_ direction: XCUIRemote.Button,
                     to element: XCUIElement,
                     maxPresses: Int = 10) -> Bool {
        guard Wait.forElementToAppear(element) else { return false }

        for _ in 0..<maxPresses {
            if element.hasFocus { return true }
            remote.press(direction)
        }
        return element.hasFocus
    }

    @discardableResult
    static func select(_ element: XCUIElement,
                       movingWith direction: XCUIRemote.Button,
                       maxPresses: Int = 10) -> Bool {
        guard move(direction, to: element, maxPresses: maxPresses) else { return false }
        remote.press(.select)
        return true
    }
}
