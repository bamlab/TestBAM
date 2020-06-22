import Foundation
import Alamofire

protocol RepositoriesAPI {
  func getRepositories(forOrganisation organisation: String,
                       completion: @escaping ([RepoModel]?) -> Void)
}

/*******************************************************************************
 * GithubAPI
 *
 * Implement function to get data from Github
 *
 ******************************************************************************/
class GithubAPI: RepositoriesAPI {

  /// Get repositories for a given organisation on Github
  func getRepositories(forOrganisation organisation: String,
                       completion: @escaping ([RepoModel]?) -> Void) {
    let url = "https://api.github.com/orgs/\(organisation)/repos"

    AF.request(url).response { response in
      guard let data = response.data else {
        completion(nil)
        return
      }

      let repoList = try? JSONDecoder().decode([RepoModel].self, from: data)
      completion(repoList)
    }
  }
}
