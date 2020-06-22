import Foundation
@testable import TestBAM

class RepositoriesAPIMocks {

  class Succeed: RepositoriesAPI {

    let result: [RepoModel] = [
      RepoModel(name: "test 1", url: "wtfurl.com"),
      RepoModel(name: "test 2", url: "test2.github.com")
    ]

    func getRepositories(forOrganisation organisation: String,
                         completion: @escaping ([RepoModel]?) -> Void) {
      completion(result)
    }
  }

  class Failure: RepositoriesAPI {

    let result: [RepoModel]? = nil

    func getRepositories(forOrganisation organisation: String,
                         completion: @escaping ([RepoModel]?) -> Void) {
      completion(result)
    }
  }

  class Empty: RepositoriesAPI {

    let result: [RepoModel]? = []

    func getRepositories(forOrganisation organisation: String,
                         completion: @escaping ([RepoModel]?) -> Void) {
      completion(result)
    }
  }
}

