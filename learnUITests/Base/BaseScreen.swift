//
//  BaseScreen.swift
//  learn
//
//  Created by Cindy Michalowski on 8/24/26.
//

import XCTest

protocol BaseScreen {}

// create an instance of the remote to navigate UI
let remote: XCUIRemote = XCUIRemote.shared

extension BaseScreen {

    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        XCUIApplication().descendants(matching: type)
    }

    var buttons: XCUIElementQuery { findAll(.button) }
    var images: XCUIElementQuery { findAll(.image) }
    var staticTexts: XCUIElementQuery { findAll(.staticText) }
    var tabBar: XCUIElementQuery { findAll(.tabBar) }
    var otherElements: XCUIElementQuery { findAll(.other) }
}
