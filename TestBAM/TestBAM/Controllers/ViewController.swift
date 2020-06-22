import UIKit

class ViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak var tableView: UITableView!

  /******************** Parameters ********************/

  let provider = BAMReposProvider()

  var list: [RepoModel] = [] {
    didSet { tableView.reloadData() }
  }

  //----------------------------------------------------------------------------
  // MARK: - View life cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()

    provider.getBAMRepositories()
  }

  private func setup() {
    setupTableView()
    setupRefreshControl()
    setupProvider()
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupRefreshControl() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self,
                             action: #selector(refreshData),
                             for: .valueChanged)
    tableView.refreshControl = refreshControl
  }

  private func setupProvider() {
    provider.delegate = self
    provider.view = self
  }

  //----------------------------------------------------------------------------
  // MARK: - Load Data
  //----------------------------------------------------------------------------

  @objc private func refreshData() {
    provider.getBAMRepositories()
  }
}

//==============================================================================
// MARK: - Table View Delegate & Data Source
//==============================================================================

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return list.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell",
                                             for: indexPath)
    let repo = list[indexPath.row]
    cell.textLabel?.text = repo.name
    cell.detailTextLabel?.text = repo.url

    return cell
  }
}

//==============================================================================
// MARK: - Repositories Provider Delegate & Data Source
//==============================================================================

extension ViewController: BAMReposProviderDelegate, BAMReposProviderView {
  func didGetRepositories(_ list: [RepoModel]) {
    self.list = list
  }

  func didFailGetRepositories() {
    // TODO
  }

  func startLoadingRepositories() {
    tableView.refreshControl?.beginRefreshing()
  }

  func stopLoadingRepositories() {
    tableView.refreshControl?.endRefreshing()
  }


}
