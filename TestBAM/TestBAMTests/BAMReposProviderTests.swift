import XCTest
@testable import TestBAM

class BAMReposProviderTests: XCTestCase {

  func testBAMReposProviderSucceed() {
    let provider = BAMReposProvider()
    let api = RepositoriesAPIMocks.Succeed()
    let delegate = MockBAMReposProviderDelegate()
    let view = MockBAMReposProviderView()

    provider.api = api
    provider.delegate = delegate
    provider.view = view

    // When
    provider.getBAMRepositories()

    // Then
    XCTAssertTrue(delegate.hasSucceed)
    XCTAssertFalse(delegate.hasFail)

    XCTAssertTrue(view.hasStartLoad)
    XCTAssertTrue(view.hasStopLoad)

    XCTAssertTrue(delegate.hasSucceed)
    XCTAssertFalse(delegate.hasFail)

    XCTAssertEqual(delegate.result?.count, 2)
    XCTAssertEqual(delegate.result, api.result)
  }

  func testBAMReposProviderSucceedEmpty() {
    let provider = BAMReposProvider()
    let api = RepositoriesAPIMocks.Empty()
    let delegate = MockBAMReposProviderDelegate()
    let view = MockBAMReposProviderView()

    provider.api = api
    provider.delegate = delegate
    provider.view = view

    // When
    provider.getBAMRepositories()

    // Then
    XCTAssertTrue(delegate.hasSucceed)
    XCTAssertFalse(delegate.hasFail)

    XCTAssertTrue(view.hasStartLoad)
    XCTAssertTrue(view.hasStopLoad)

    XCTAssertTrue(delegate.hasSucceed)
    XCTAssertFalse(delegate.hasFail)

    XCTAssertEqual(delegate.result, api.result)
    XCTAssertEqual(delegate.result?.count, 0)
  }

  func testBAMReposProviderFail() {
    let provider = BAMReposProvider()
    let api = RepositoriesAPIMocks.Failure()
    let delegate = MockBAMReposProviderDelegate()
    let view = MockBAMReposProviderView()

    provider.api = api
    provider.delegate = delegate
    provider.view = view

    // When
    provider.getBAMRepositories()

    // Then
    XCTAssertFalse(delegate.hasSucceed)
    XCTAssertTrue(delegate.hasFail)

    XCTAssertTrue(view.hasStartLoad)
    XCTAssertTrue(view.hasStopLoad)

    XCTAssertTrue(delegate.hasFail)
    XCTAssertFalse(delegate.hasSucceed)

    XCTAssertEqual(delegate.result, api.result)
    XCTAssertEqual(delegate.result, nil)
  }
}
