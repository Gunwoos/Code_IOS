//
//  AppDelegate.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 23..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  static var instance: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    setupRootViewController()
    return true
  }
  
  func setupRootViewController() {
    
  }
}

