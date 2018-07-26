//
//  LoginTextField.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 7. 22..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

@IBDesignable
final class LoginTextField: UITextField {
  
  @IBInspectable var leftImage: UIImage? {
    get { return (leftView as? UIImageView)?.image }
    set {
      let image = newValue?.withRenderingMode(.alwaysTemplate)
      let leftImageView = UIImageView(image: image)
      leftImageView.tintColor = .blue
      leftView = leftImageView
      leftViewMode = .always
    }
  }
  
  var borderLayer: CALayer?
  @IBInspectable var underlineWidth: CGFloat {
    get { return self.borderLayer?.borderWidth ?? 0.0 }
    set {
      let borderLayer = CALayer()
      borderLayer.frame = CGRect(x: 0, y: frame.height + 20, width: frame.width, height: 1)
      borderLayer.borderWidth = newValue
      borderLayer.borderColor = UIColor.lightGray.cgColor
      layer.addSublayer(borderLayer)
      self.borderLayer = borderLayer
    }
  }
}
