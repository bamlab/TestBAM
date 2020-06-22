import UIKit

class ViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlets ********************/

  @IBOutlet weak var tableView: UITableView!

  private let noDataView = EmptyTableView()

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
    showNoDataView(false)
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self

    tableView.backgroundView = noDataView
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

  private func showNoDataView(_ hasNoData: Bool) {
    self.tableView.backgroundView?.isHidden = !hasNoData
    self.tableView.separatorStyle = hasNoData ? .none : .singleLine
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
    showNoDataView(false)
  }

  func didFailGetRepositories() {
    self.list = []
    showNoDataView(true)
  }

  func startLoadingRepositories() {
    tableView.refreshControl?.beginRefreshing()
  }

  func stopLoadingRepositories() {
    tableView.refreshControl?.endRefreshing()
  }


}
