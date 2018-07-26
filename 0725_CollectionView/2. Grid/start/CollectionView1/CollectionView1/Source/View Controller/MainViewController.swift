import UIKit

final class MainViewController: UIViewController {
  
  private struct Metric {
    // collectionView
    
  }
  
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
    
    collectionView.register(
      UINib(nibName: "CardCell", bundle: nil),
      forCellWithReuseIdentifier: "CardCell"
    )
    fetchData()
  }
  
}

// MARK: - Fetch
extension MainViewController {
  private func fetchData() {
    ImageService.image { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let images):
        self.source = images
      case .failure(let error):
        print(error)
      }
    }
  }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return source.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cellData = source[indexPath.item]
//
//    let cell = collectionView.dequeueReusableCell(
//      withReuseIdentifier: "ImageCell",
//      for: indexPath
//    ) as! ImageCell
//    cell.cardImage.image = UIImage(named: cellData.image)
//    cell.nameLabel.text = cellData.name
//    return cell
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
    cell.imageView.image = UIImage(named: cellData.image)
    cell.nameLabel.text = cellData.name
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    <#code#>
  }
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    <#code#>
  }
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    <#code#>
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    <#code#>
  }
}

