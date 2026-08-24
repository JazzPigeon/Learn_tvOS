//
//  BaseScreen.swift
//  learn
//
//  Created by Cindy Michalowski on 8/24/26.
//

import XCTest

protocol BaseScreen {}

extension BaseScreen {

    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        XCUIApplication().descendants(matching: type)
    }

    var buttons: XCUIElementQuery { findAll(.button) }
    var staticTexts: XCUIElementQuery { findAll(.staticText) }
    var otherElements: XCUIElementQuery { findAll(.other) }
}
