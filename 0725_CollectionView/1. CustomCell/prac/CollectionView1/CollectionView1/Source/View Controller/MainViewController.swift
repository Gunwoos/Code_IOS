import UIKit

final class MainViewController: UIViewController {
  
  // MARK: Properties
  @IBOutlet weak var collectionView: UICollectionView!
  var source: [Card] = [] {
    didSet {
      self.collectionView.reloadData()
    }
  }
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}

// MARK: - Fetch
extension MainViewController {
  
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    <#code#>
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    <#code#>
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    <#code#>
  }
}
