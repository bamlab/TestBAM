import XCTest

class TestBAMUITests: XCTestCase {

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testTableViewContent() throws {
    // UI tests must launch the application that they test.
    let app = XCUIApplication()
    app.launch()

    XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["node-spotify"].exists)
    XCTAssertTrue(XCUIApplication().tables.cells.staticTexts["bam-app-dej"].exists)
  }

}
