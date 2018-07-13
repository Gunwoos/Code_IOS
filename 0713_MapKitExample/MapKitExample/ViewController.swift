//
//  ViewController.swift
//  MapKitExample
//
//  Created by giftbot on 2018. 7. 12..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit
  
final class ViewController: UIViewController {

  let viewControllers = [MyLocationViewController(), GeocodeViewController(), BasicAnnotationViewController(), RendererOverlayViewController(), CalloutActionViewController()]
  let titles = ["MyLocationViewController", "GeocodeViewController", "BasicAnnotationViewController", "RendererOverlayViewController","CalloutActionViewController"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "\(titles[indexPath.row])"
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: titles[indexPath.row])
    navigationController?.pushViewController(vc, animated: true)
  }
}



