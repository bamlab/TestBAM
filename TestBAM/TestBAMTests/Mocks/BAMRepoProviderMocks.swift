import Foundation
@testable import TestBAM

class MockBAMReposProviderView: BAMReposProviderView {
  var hasStartLoad = false
  var hasStopLoad = false

  func startLoadingRepositories() {
    hasStartLoad = true
  }

  func stopLoadingRepositories() {
    hasStopLoad = true
  }
}

class MockBAMReposProviderDelegate: BAMReposProviderDelegate {
  var result: [RepoModel]? = nil
  var hasFail = false
  var hasSucceed = false

  func didGetRepositories(_ list: [RepoModel]) {
    hasSucceed = true
    result = list
  }

  func didFailGetRepositories() {
    hasFail = true
  }


}
