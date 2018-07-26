import UIKit

final class MainContentCell: UITableViewCell {
  
  // Metric
  private struct Metric {
    static let numberOfItem: CGFloat = 1
    static let numberOfLine: CGFloat = 1
    
    static let topPadding: CGFloat = 5.0
    static let leftPadding: CGFloat = 20.0
    static let bottomPadding: CGFloat = 5.0
    static let rightPadding: CGFloat = 20.0
    
    static let lineSpacing: CGFloat = 10.0
    static let itemSpacing: CGFloat = 10.0
    
    static let nextOffset: CGFloat = 10.0
  }
  
  // MARK: Properties
  @IBOutlet weak var flagImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  var source: Cards? {
    didSet {
      self.collectionView.reloadData()
    }
  }
  var offset: CGFloat {
    get {
      return collectionView.contentOffset.x
    }
    set {
      collectionView.contentOffset.x = newValue
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    collectionView.register(
      UINib(nibName: "CardCell", bundle: nil),
      forCellWithReuseIdentifier: "CardCell"
    )
  }
}


// MARK: - UICollectionViewDataSource
extension MainContentCell: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return source?.cards.count ?? 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cellData = source?.cards[indexPath.item] else { return UICollectionViewCell() }
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
    cell.imageView.image = UIImage(named: cellData.image)
    cell.nameLabel.text = cellData.name
    return cell
  }
}

extension MainContentCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let lineSpacing = Metric.lineSpacing * (Metric.numberOfLine - 1)
    let horizontalPadding = Metric.leftPadding + Metric.lineSpacing + Metric.nextOffset
    let itemSpacing = Metric.itemSpacing * (Metric.numberOfItem - 1)
    let verticalPadding = Metric.topPadding + Metric.bottomPadding
    let width = (collectionView.frame.width - lineSpacing - horizontalPadding) / Metric.numberOfLine
    let height = (collectionView.frame.height - itemSpacing - verticalPadding) / Metric.numberOfItem
    return CGSize(width: width, height: height)
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
