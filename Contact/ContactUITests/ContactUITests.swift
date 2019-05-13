//
//  ContactUITests.swift
//  ContactUITests
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import XCTest

class ContactUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFirstScreen() {
        let app = XCUIApplication()
        
        XCTAssertEqual(app.navigationBars.element(boundBy: 0).identifier, "Contact")
    }
    
    func testAddContactAndCancelScreen() {
        
        let app = XCUIApplication()
        let addButton = app.navigationBars["Contact"].buttons["Add"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()
        XCTAssertEqual(app.navigationBars.element(boundBy: 0).identifier, "Contact")
                ///
    }
    
    func testAddingValidContact() {
        let firstName = "Ankit"
        let lastname = "testing"
        let mobile = "9999999999"
        let email = "testing@testing.com"
        
        let app = XCUIApplication()
        app.navigationBars["Contact"].buttons["Add"].tap()
        let tablesQuery = app.tables
        let table = app.tables.element(boundBy: 0)
        let firstTextField = table.cells.element(boundBy: 0)
//        let firstTextField = tablesQuery.tables.cells.containing(.staticText, identifier:"First Name").children(matching: .textField).element
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: firstTextField, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertTrue(firstTextField.exists)
        firstTextField.tap()
        firstTextField.typeText(firstName)
        
        let lastTextField =  tablesQuery.cells.containing(.staticText, identifier:"Last Name").children(matching: .textField).element
        XCTAssertTrue(lastTextField.exists)
        lastTextField.tap()
        lastTextField.typeText(lastname)
        
        let mobileTextField =  tablesQuery.cells.containing(.staticText, identifier:"mobile").children(matching: .textField).element
        XCTAssertTrue(mobileTextField.exists)
        mobileTextField.tap()
        mobileTextField.typeText(mobile)
        
        let emailTextField =  tablesQuery.cells.containing(.staticText, identifier:"email").children(matching: .textField).element
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let doneButton = app.buttons["Done"]
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()
        //
        
    }
}
