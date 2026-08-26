//
//  DashboardScreen.swift
//  learn
//
//  Created by Cindy Michalowski on 8/24/26.
//

import XCUIAutomation
import XCTest

class DashboardScreen: BaseScreen {
    
    // MARK: Element Locators
    
    lazy var imgProfilePic = images["ic-profile"].firstMatch
    lazy var txtUserName = staticTexts["JazzPigeon"].firstMatch
    lazy var imgFavorite = images["Favorite"].firstMatch
    lazy var imgViewfinder = images["plus.viewfinder"].firstMatch
    lazy var imgWifi = images["Wi-Fi"].firstMatch
    lazy var txtCurrTime = staticTexts["12:14 PM"].firstMatch
    
    lazy var tabBar = tabBar["Menu"].firstMatch
    lazy var btnCategory = { self.buttons[$0].firstMatch }
    lazy var imgCategory = {self.images[$0].firstMatch }
    
    lazy var btnGame = { self.buttons[$0].firstMatch }
    lazy var txtGameTitle = { self.staticTexts[$0].firstMatch }
    lazy var lblTimePlayed = staticTexts["Time played"].firstMatch
    lazy var txtTimePlayed = { self.staticTexts[$0].firstMatch }
    lazy var lblProgress = staticTexts["Progress"].firstMatch
    lazy var txtProgress = { self.staticTexts[$0].firstMatch }
    lazy var lblLastMedal = staticTexts["Last medal"].firstMatch
    lazy var txtLastMedal = { self.staticTexts[$0].firstMatch }
    
    
    // MARK: Actions
    
    @discardableResult
    func navigateToTabBar() -> DashboardScreen {
        // Verify that tab bar is focused, then select the tab
        Focus.move(.up, to: btnCategory("Games"))
        return self
    }
    
    
    // MARK: Asssertions
    
    @discardableResult
    func isDisplayedAsExpectedOnLaunch() -> DashboardScreen {
        assertUserProfile()
        assertConnectionAndTime()
        assertTabBar()
        assertGamesAndMetadata()
        return self
    }
    
    @discardableResult
    func assertUserProfile() -> DashboardScreen {
        XCTAssert(imgProfilePic.waitForExistence(timeout: 10), "User profile image is missing from the Dashboard")
        XCTAssert(txtUserName.exists, "User name is missing from the Dashboard")
        XCTAssert(imgFavorite.exists, "Favorites icon is missing from the Dashboard")
        XCTAssert(imgViewfinder.exists, "Viewfinder icon is missing from the Dashboard")
        return self
    }
    
    @discardableResult
    func assertConnectionAndTime() -> DashboardScreen {
        XCTAssert(imgWifi.waitForExistence(timeout: 10), "WiFi is missing from the Dashboard")
        XCTAssert(txtCurrTime.exists, "Time is missing from the Dashboard")
        return self
    }
    
    @discardableResult
    func assertTabBar() -> DashboardScreen {
        XCTAssert(tabBar.waitForExistence(timeout: 10), "Tab Bar is missing from the Dashboard")
        
        // MARK: FIX - Don't hardcode
        Focus.move(.up, to: btnCategory("Games"))
        
        XCTAssert(btnCategory(Dashboard.Menu.games.rawValue).hasFocus, "'Games' button is not selected by default upon launch")
        
        for item in Dashboard.Menu.allCases {
            XCTAssert(btnCategory(item.rawValue).exists, "'\(item.rawValue)' button is missing from the Tab Bar")
            XCTAssert(imgCategory(item.image).exists, "'\(item.image)' image is missing from the Tab Bar")
        }
        return self
    }
    
    @discardableResult
    func assertGamesAndMetadata() -> DashboardScreen {
        let firstGameName = GamesModel.getGames().first?.name ?? ""
        
        // MARK: Fix hardcoded string
        Focus.move(.down)
        Focus.move(.left, to: btnGame("ic-game-1"))
        
        XCTAssert(txtGameTitle(firstGameName).exists, "Selected game title is missing from Dashboard")
        
        let expectedVisibleCount = 6
        let visibleGames = GamesModel.getGames().prefix(expectedVisibleCount)

        for game in visibleGames {
            XCTAssert(
                btnGame(game.image).exists,
                "'\(game.name)' button is missing from the Dashboard"
            )
        }
        
        let firstGameTimePlayed = GamesModel.getGames().first?.timePlayed ?? ""
        let firstGameProgress = GamesModel.getGames().first?.progress ?? ""
        let firstGameLastMedal = GamesModel.getGames().first?.medal ?? ""
        
        XCTAssert(lblTimePlayed.exists, "'Time played' label is missing from Dashboard")
        XCTAssert(txtTimePlayed(firstGameTimePlayed).exists, "'Time played' data is missing or incorrect") // 5h 6m
        
        XCTAssert(lblProgress.exists, "'Progress' label is missing from Dashboard")
        XCTAssert(txtProgress(firstGameProgress).exists, "'Progress' data is missing or incorrect") // 19%
        
        XCTAssert(lblLastMedal.exists, "'Last medal' label is missing from Dashboard")
        XCTAssert(txtLastMedal(firstGameLastMedal).exists, "'Last medal' data is missing or incorrect") // Bronze
        return self
    }
}
