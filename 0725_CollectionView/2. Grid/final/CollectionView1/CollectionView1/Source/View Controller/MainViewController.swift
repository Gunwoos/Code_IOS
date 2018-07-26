import UIKit

final class MainViewController: UIViewController {
  
  private struct Metric {
    // collectionView
    static let numberOfItem: CGFloat = 3
    static let numberOfLine: CGFloat = 3
    
    static let leftPadding: CGFloat = 10.0
    static let rightPadding: CGFloat = 10.0
    static let topPadding: CGFloat = 10.0
    static let bottomPadding: CGFloat = 10.0
    
    static let itemSpacing: CGFloat = 10.0
    static let lineSpacing: CGFloat = 10.0
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
    let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
    let horizontalPadding = Metric.leftPadding + Metric.rightPadding
    let totalSpacing = itemSpacing + horizontalPadding
    let width = (collectionView.frame.width - totalSpacing) / Metric.numberOfItem
    return CGSize(width: width, height: width)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return Metric.lineSpacing
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return Metric.itemSpacing
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return UIEdgeInsetsMake(Metric.topPadding, Metric.leftPadding,
                            Metric.bottomPadding, Metric.rightPadding)
  }
}

