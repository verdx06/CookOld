//
//  SearchScreenUITests.swift
//  CulinarAppUITests
//
//  Created by Варя Черепенникова on 08.04.2026.
//

import XCTest

final class SearchScreenUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["--uitesting"]
        app.launch()
        app.buttons["Поиск"].tap()
    }

    func testSearchBarExists() {
        let searchBar = app.textFields["searchBar"]
        XCTAssertTrue(searchBar.exists)
    }

    func testTypingInSearchBar() {
        let searchBar = app.textFields["searchBar"]
        searchBar.tap()
        searchBar.typeText("chicken")
        XCTAssertEqual(searchBar.value as? String, "chicken")
    }

    func testClearButtonAppearsWhenFocused() {
        let searchBar = app.textFields["searchBar"]
        searchBar.tap()
        searchBar.typeText("test")
        XCTAssertTrue(app.buttons["clearSearchButton"].waitForExistence(timeout: 1))
    }

    func testCategoriesLoad() {
        let firstCategory = app.buttons["categoryCard_0"]
        XCTAssertTrue(firstCategory.waitForExistence(timeout: 5))
    }

    func testTapCategoryNavigatesToFilterScreen() {
        let firstCategory = app.buttons["categoryCard_0"]
        XCTAssertTrue(firstCategory.waitForExistence(timeout: 5))
        firstCategory.tap()
        let searchBar = app.textFields["searchBar"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5))
    }
}
