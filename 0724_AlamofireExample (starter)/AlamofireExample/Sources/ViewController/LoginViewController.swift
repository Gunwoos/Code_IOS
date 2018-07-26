//
//  LoginViewController.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
  
  @IBOutlet private weak var usernameTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  @IBAction private func requestSignIn(_ sender: UIButton) {
  }

  deinit {
    print("\(self) has deinitialized")
  }
}
