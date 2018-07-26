//
//  MainViewController.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  private var postService: PostServiceType?
  private var postList: [Post] = []
  
  static func create(with postService: PostServiceType = PostService()) -> UINavigationController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let `self` = storyboard.instantiateViewController(ofType: self.self)
    let navigation = UINavigationController(rootViewController: `self`)
    self.postService = postService
    return navigation
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    postService?.retrievePostList(completion: { [weak self] (result) in
      switch result {
      case .success(let postList):
        self?.postList = postList
        self?.tableView.reloadData()
        
      case .error(let error):
        print(error)
      }
    })
  }
  
  @IBAction private func signOut(_ sender: UIButton) {
    UserManager.token = nil
    AppDelegate.instance.setupRootViewController()
  }
  
  @IBAction private func showPostViewController(_ sender: UIButton) {
    let vc = PostViewController.create()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  deinit {
    print("\(self) has deinitialized")
  }
}


// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let post = postList[indexPath.row]
    cell.tag = indexPath.row
    cell.textLabel?.text = post.title
    cell.detailTextLabel?.text = post.content
    
    if let imgURL = post.imageLink {
      downloadImage(for: cell, with: imgURL, at: indexPath)
    } else {
      //    cell.imageView?.image = UIImage(named: "image1")
      cell.imageView?.image = nil
    }
    return cell
  }
  
  private func downloadImage(for cell: UITableViewCell, with url: String, at indexPath: IndexPath) {
    postService?.downloadImage(imgURL: url) {
      guard let image = $0 else { return }
      DispatchQueue.main.async {
//        print("cell.tag :", cell.tag, " / indexPath.row :", indexPath.row)
        if cell.tag == indexPath.row {
          cell.imageView?.image = image
          cell.setNeedsLayout()
        }
      }
    }
  }
}


