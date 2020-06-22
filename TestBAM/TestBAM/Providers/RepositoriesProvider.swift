import Foundation

protocol RepositoriesProviderView: class {
  func startLoadingRepositories()
  func stopLoadingRepositories()
}

protocol RepositoriesProviderDelegate: class {
  func didGetRepositories(_ list: [RepoModel])
  func didFailGetRepositories()
}

/*******************************************************************************
 * <#Class name#>
 *
 * <#description#>
 *
 ******************************************************************************/
class ReposProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  weak var delegate: RepositoriesProviderDelegate?
  weak var view: RepositoriesProviderView?

  /******************** API ********************/

  var api: RepoAPI = GithubAPI()

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func getBAMRepositories() {
    view?.startLoadingRepositories()

    api.getRepositories(forOrganisation: "bamlab") { [weak self] repoList in
      self?.view?.stopLoadingRepositories()

      guard let list = repoList else {
        self?.delegate?.didFailGetRepositories()
        return
      }

      self?.delegate?.didGetRepositories(list)
    }
  }
}
