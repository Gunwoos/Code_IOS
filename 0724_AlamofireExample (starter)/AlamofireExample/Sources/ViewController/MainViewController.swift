//
//  MainViewController.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 7. 23..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
     
  }
  
  @IBAction private func logout(_ sender: Any) {

  }
}


// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}
