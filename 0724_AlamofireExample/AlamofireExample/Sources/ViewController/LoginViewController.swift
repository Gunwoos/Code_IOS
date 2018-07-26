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
  var authService: AuthServiceType?
  
  static func create(with authService: AuthServiceType = AuthService()) -> Self {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let `self` = storyboard.instantiateViewController(ofType: self.self)
    self.authService = authService
    return self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameTextField.text = "giftbot"
    passwordTextField.text = "giftbot"
    usernameTextField.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    view.endEditing(true)
  }
  
  @IBAction private func requestSignIn(_ sender: UIButton) {
    guard let username = usernameTextField.text,
      let password = passwordTextField.text
      else { return }
    
    authService?.signIn(username: username, password: password) { [weak self] result in
      switch result {
      case .success(let user):
        print("Login user :", user)
        AppDelegate.instance.setupRootViewController()
        self?.presentingViewController?.dismiss(animated: true)
      case .error(let error):
        print(error.localizedDescription)
      }
    }
  }

  deinit {
    print("\(self) has deinitialized")
  }
}
