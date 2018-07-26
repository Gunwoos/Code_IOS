//
//  EntryViewController.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 7. 22..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class EntryViewController: UIViewController {
  
  static func create() -> Self {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let `self` = storyboard.instantiateViewController(ofType: self.self)
    return self
  }
  
  @IBAction private func presentLogin(_ sender: Any) {
    show(LoginViewController.create(), sender: nil)
  }
  
  @IBAction private func presentSignUp(_ sender: Any) {
    show(SignUpViewController.create(), sender: nil)
  }
  
  @IBAction func unwindToEntry(_ sender: UIStoryboardSegue) {
  }
  
  deinit {
    print("\(self) has deinitialized")
  }
}
