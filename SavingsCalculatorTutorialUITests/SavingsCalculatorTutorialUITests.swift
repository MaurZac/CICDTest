//
//  SavingsCalculatorTutorialUITests.swift
//  SavingsCalculatorTutorialUITests
//
//  Created by MaurZac on 15/01/26.
//
import Foundation
import XCTest
@testable import SavingsCalculatorTutorial

final class SavingsCalculatorTutorialUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.navigationBars["Savings Calculator"].waitForExistence(timeout: 3.0))
        let initialDeposit = 10_000.0
        let monthlyContribution = 200.0
        let annualRate = 0.037
        let months = 10 * 12
        let monthlyRate = annualRate / 12.0
        //XCTAssertTrue(app.textFields[initialDeposit.initialDeposit.formattedAsCurrency()].exists)
        XCTAssertTrue(app.textFields[monthlyContribution.formattedAsCurrency()].exists)
        XCTAssertTrue(app.textFields[String(months / 12)].exists)
        //XCTAssertTrue(app.textFields[String(annualRate * 100)].exists)
        
        app.buttons["Calculate"].tap()
        
        let resultsNav = app.navigationBars["Results"]
        XCTAssertTrue(resultsNav.waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Initial Deposit"].exists)
        XCTAssertTrue(app.staticTexts["Contributions"].exists)
        //(app.staticTexts["Here's how your savings break down over time:"].exists)
        //XCTAssertTrue(app.staticTexts["Savings after \(months / 12) years"].exists)
        
    }

    @MainActor
    func testEditInputAndCalculate() throws {
       let app = XCUIApplication()
        app.launch()
        let initialDepositField = app.textFields.element(boundBy: 0)
        let monthlyContributionField = app.textFields.element(boundBy: 1)
        let yearsField = app.textFields.element(boundBy: 2)
        let yieldField = app.textFields.element(boundBy: 3)
        let yearsString = "20"
        
        XCTAssertTrue(initialDepositField.exists)
        initialDepositField.tap()
        XCTAssertTrue(initialDepositField.value as? String  == "$0")
        initialDepositField.typeText("20000")
        XCTAssertTrue(initialDepositField.value as? String  == "$20,000")
        
        XCTAssertTrue(monthlyContributionField.exists)
        monthlyContributionField.tap()
        XCTAssertTrue(monthlyContributionField.value as? String  == "$0")
        monthlyContributionField.typeText("500")
        XCTAssertTrue(monthlyContributionField.value as? String  == "$500")

        
        XCTAssertTrue(yearsField.exists)
        yearsField.tap()
        XCTAssertTrue(yearsField.value as? String  == "0")
        yearsField.typeText(yearsString)
        
        XCTAssertTrue(yieldField.exists)
        yieldField.tap()
        XCTAssertTrue(yieldField.value as? String  == "0")
        yieldField.typeText("4")
        
        
        
        app.buttons["Calculate"].tap()
        
        let resulsNav = app.navigationBars["Results"]
        XCTAssertTrue(resulsNav.waitForExistence(timeout: 3))
        
        XCTAssertTrue(app.staticTexts["Initial Deposit"].exists)
        XCTAssertTrue(app.staticTexts["Savings after \(yearsString) years:"].exists)
        
        
    }
    
    @MainActor
    func testBackNavigationPerservesInputs()  throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.navigationBars["Savings Calculator"].waitForExistence(timeout: 3))
        let initialDepositField = app.textFields.element(boundBy: 0)
        let monthlyContributionField = app.textFields.element(boundBy: 1)
        let yearsField = app.textFields.element(boundBy: 2)
        let yieldField = app.textFields.element(boundBy: 3)
        
        initialDepositField.tap()
        initialDepositField.typeText("20000")
        
        monthlyContributionField.tap()
        monthlyContributionField.typeText("600")
        
        yearsField.tap()
        yearsField.typeText("20")
        
        yieldField.tap()
        yieldField.typeText("4.5")
        
        app.buttons["Calculate"].tap()
        
        XCTAssertTrue(app.navigationBars["Results"].waitForExistence(timeout: 3))
        
        app.navigationBars["Results"].buttons.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.textFields["$20,000"].exists)
        XCTAssertTrue(app.textFields["$600"].exists)
        XCTAssertTrue(app.textFields["20"].exists)
        XCTAssertTrue(app.textFields["4.5"].exists)
        
    }
}

extension Double {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
