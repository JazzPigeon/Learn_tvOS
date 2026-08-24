//
//  BaseTest.swift
//  learn
//
//  Created by Cindy Michalowski on 8/24/26.
//

import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // if an assertion fails in the course of running a test, test will stop
        continueAfterFailure = false
        
//        app.launchArguments += [
//            "-disableAnimations"
//        ]
        
        app.launch()
    }
    
    // Tear Down
    override func tearDown() {
        // if test fails, capture screenshot at point of failure; delete tearDown screenshot if test passes
        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        add(fullScreenshotAttachment)
        
        // the element hierarchy is only readable while the app is alive, so capture it before terminating
        if testRun?.hasSucceeded == false, app.state == .runningForeground {
            let hierarchy = XCTAttachment(string: app.debugDescription)
            hierarchy.name = "Element hierarchy at failure"
            hierarchy.lifetime = .keepAlways
            add(hierarchy)
        }
        
        // terminate app
        app.terminate()
    }
}
