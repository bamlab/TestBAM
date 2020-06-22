import XCTest
@testable import TestBAM

class GithubAPITests: XCTestCase {

  func testGithubAPIGetRepositories() {
    let api = GithubAPI()
    let expectation = XCTestExpectation(description: "Fet repositories")

    // When
    api.getRepositories(forOrganisation: "bamlab") { repoList in

      // Then
      XCTAssertNotNil(repoList)
      XCTAssertGreaterThan(repoList?.count ?? 0, 0)

      expectation.fulfill()
    }

    wait(for: [expectation], timeout: 5.0)
  }

}
