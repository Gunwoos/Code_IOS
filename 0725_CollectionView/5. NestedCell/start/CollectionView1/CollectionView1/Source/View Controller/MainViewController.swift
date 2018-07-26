import UIKit

final class MainViewController: UIViewController {
  
  // MARK: Properties
  @IBOutlet private weak var tableView: UITableView!
  private var source: [Cards] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchData()
  }
  
}

// MARK: - Fetch
extension MainViewController {
  private func fetchData() {
    ImageService.image { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let cards):
        self.source = cards
      case .failure(let error):
        print(error)
      }
    }
  }
}

extension MainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return source.count 
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
   <#code#>
  }
}

extension MainViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 250
  }
  
  func tableView(
    _ tableView: UITableView,
    willDisplay cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    <#code#>
  }
  
  func tableView(
    _ tableView: UITableView,
    didEndDisplaying cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    <#code#>
  }
}









