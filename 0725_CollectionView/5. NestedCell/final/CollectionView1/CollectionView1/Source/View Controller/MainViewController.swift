import UIKit

final class MainViewController: UIViewController {
  
  // MARK: Properties
  @IBOutlet private weak var tableView: UITableView!
  private var source: [Cards] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  private var cachedOffset: [Int: CGFloat] = [:]
  
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
    let cards = source[indexPath.item]
    
    if indexPath.row % 2 == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MainContentCell", for: indexPath) as! MainContentCell
      cell.flagImageView.image = UIImage(named: cards.state)
      cell.nameLabel.text = cards.state
      cell.source = cards
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SubContentCell", for: indexPath) as! SubContentCell
      cell.source = cards
      return cell
    }
    
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
    if indexPath.row % 2 == 0 {
      let cell = cell as! MainContentCell
      cell.offset = cachedOffset[indexPath.row] ?? 0
    } else {
      let cell = cell as! SubContentCell
      cell.offset = cachedOffset[indexPath.row] ?? 0
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    didEndDisplaying cell: UITableViewCell,
    forRowAt indexPath: IndexPath
  ) {
    if indexPath.row % 2 == 0 {
      let cell = cell as! MainContentCell
      cachedOffset[indexPath.row] = cell.offset
    } else {
      let cell = cell as! SubContentCell
      cachedOffset[indexPath.row] = cell.offset
    }
  }
}









