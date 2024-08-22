//
//  blukersUITests.swift
//  blukersUITests
//
//  Created by Victor Marius on 2/15/24.
//

import XCTest

final class blukersUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        // UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

  func testUserNavigationThroughApp() throws {
      let app = XCUIApplication()
      setupSnapshot(app) // Prepare for snapshot
      app.launch()

      // Start of recorded actions
      app.staticTexts["I AM A\nWORKER\nLOOKING FOR JOBS"].tap()
      snapshot("01_WorkerJobScreen") // Screenshot of the job search screen

      let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
      element.tap()

      let custodialWorkImage = app.images["Custodial Work"]
      custodialWorkImage.swipeUp()

      let element2 = element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
      element2.children(matching: .other).element(boundBy: 3).children(matching: .scrollView).element.tap()
      app.images["Agriculture"].tap()
      snapshot("02_AgricultureJobsScreen") // Screenshot after selecting Agriculture

      custodialWorkImage.swipeUp()
      app.images["Commercial Fishing"].tap()
      snapshot("03_CommercialFishingJobsScreen") // Screenshot after selecting Commercial Fishing

      app.staticTexts["Painter\nSalary: $25,000 - $50,000\n565"].tap()
      snapshot("04_PainterJobDetail") // Screenshot of a job detail screen

      let element3 = app.otherElements["1 day ago\nJourneymen Painter\nNot Specified\nFull Time\nMonday to Friday\nFloor Coverings International\nAmarillo,  TX, Texas, United States\nF"]
      element3.swipeUp()

      let xElement = app.otherElements["X"]
      xElement.tap()
      element3.swipeUp()
      xElement.tap()
      xElement.tap()

      let scrollView = element2.children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 1).children(matching: .scrollView).element
      scrollView.swipeUp()
      app.otherElements["7 days ago\nBlaster Painter\nNot Specified\nFull Time\nMonday to Friday\nHutco, Inc - Marine and Shipyard Staffing\nHouston,  TX, Texas, United States\nH"].swipeUp()
      snapshot("05_BlasterPainterJobScroll") // Screenshot during job listings scroll

      xElement.tap()
      element3.swipeUp()
      xElement.tap()
      scrollView.swipeUp()
      scrollView.swipeUp()
      xElement.tap()
      scrollView.swipeUp()
      scrollView.swipeUp()
      xElement.tap()
      scrollView.swipeUp()
      xElement.tap()
      scrollView.swipeUp()
      scrollView.tap()
      scrollView.swipeUp()
      // Optionally, add more snapshots here if there are more screens of interest
  }


}
