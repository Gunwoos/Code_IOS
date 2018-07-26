//
//  LoginButton.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 7. 22..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit


@IBDesignable
final class LoginButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }
  
  @IBInspectable var borderColor: UIColor {
    get { return UIColor(cgColor: layer.borderColor ?? UIColor.blue.cgColor) }
    set { layer.borderColor = newValue.cgColor }
  }
}
