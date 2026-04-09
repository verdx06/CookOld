//
//  CategoryFilterUITests.swift
//  CulinarAppUITests
//
//  Created by Варя Черепенникова on 08.04.2026.
//

import XCTest

final class CategoryFilterUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["--uitesting"]
        app.launch()
        app.buttons["Поиск"].tap()
        let firstCategory = app.buttons["categoryCard_0"]
        XCTAssertTrue(firstCategory.waitForExistence(timeout: 5))
        firstCategory.tap()
    }

    func testMealsLoadAfterNavigation() {
        let firstMeal = app.buttons["heart"].firstMatch
        XCTAssertTrue(firstMeal.waitForExistence(timeout: 5))
    }

    func testSearchBarFiltersMeals() {
        XCTAssertTrue(app.buttons["heart"].firstMatch.waitForExistence(timeout: 5))
        let searchBar = app.textFields["searchBar"]
        searchBar.tap()
        searchBar.typeText("a")
        let hasResults = app.buttons["heart"].firstMatch.waitForExistence(timeout: 5)
        let hasEmpty = app.staticTexts["Ничего не найдено"].exists
        XCTAssertTrue(hasResults || hasEmpty)
    }

    func testBackButtonReturnsToSearch() {
        XCTAssertTrue(app.textFields["searchBar"].waitForExistence(timeout: 5))
        app.navigationBars.buttons["Назад"].tap()
        XCTAssertTrue(app.buttons["categoryCard_0"].waitForExistence(timeout: 5))
    }
}
