//
//  BallisLifeUITests.swift
//  BallisLifeUITests
//
//  Created by Usman Shafique on 2/11/16.
//  Copyright © 2016 AAUS. All rights reserved.
//

import XCTest

class BallisLifeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results

        XCUIApplication().launch()
        let app = XCUIApplication()
        app.otherElements.containingType(.NavigationBar, identifier:"Current Location").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.pressForDuration(2.1);
        app.otherElements["Rodrigues Ave"].tap()
        app.buttons["yes 50x50"].tap()
        app.alerts["Soccer"].collectionViews.buttons["Yes!"].tap()
        
    }
    
}
