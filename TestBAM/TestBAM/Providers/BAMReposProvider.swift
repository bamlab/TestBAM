import Foundation

protocol BAMReposProviderView: class {
  func startLoadingRepositories()
  func stopLoadingRepositories()
}

protocol BAMReposProviderDelegate: class {
  func didGetRepositories(_ list: [RepoModel])
  func didFailGetRepositories()
}

/*******************************************************************************
 * ReposProvider
 *
 * Access to API requests for bam repositories data
 *
 ******************************************************************************/
class BAMReposProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  weak var delegate: BAMReposProviderDelegate?
  weak var view: BAMReposProviderView?

  /******************** API ********************/

  var api: RepositoriesAPI = GithubAPI()

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
