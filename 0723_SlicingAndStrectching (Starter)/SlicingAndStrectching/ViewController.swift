//
//  ViewController.swift
//  SlicingAndStrectching
//
//  Created by giftbot on 2018. 7. 21..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var circleImageView: UIImageView!
  @IBOutlet private weak var flagImageView: UIImageView!
  @IBOutlet private weak var bubbleImageView: UIImageView!
  @IBOutlet private weak var messageLabel: UILabel!
    let textList = [
        """
        Tory
        """,
        """
        Hello, Swift!
        Hello, iOS!
        """,
        """
        Hello, World!! Swift
        Hello, Swift!
        Resizable
        Slicing
        """,
        """
        Hello, World!!
        Hello, iOS!
        Resizable
        Stretching / Slicing / ImageView.resizable
        UIEdgeInsetsMake
        bubbleImageView / bubbleImageView / ...
        """,
        """
        Hello, Swift!!
        Hello, iOS!
        Stretching / Slicing / ImageView.resizable
        Resizable
        UIEdgeInsetsMake
        Hello, Swift!
        bubbleImageView / bubbleImageView / ...
        Hello, Swift!
        Hello, iOS!
        """,
        """
        Hello, Swift!!
        Hello, iOS!
        Stretching / Slicing / ImageView.resizable
        Resizable
        UIEdgeInsetsMake
        Hello, Swift!
        bubbleImageView / bubbleImageView / ...
        Hello, Swift!
        Hello, iOS!
        """,
        """
        Hello, Swift!!
        Hello, iOS!
        Stretching / Slicing / ImageView.resizable
        Resizable
        UIEdgeInsetsMake
        Hello, Swift!
        bubbleImageView / bubbleImageView / ...
        Hello, Swift!
        Stretching / Slicing / ImageView.resizable
        Resizable
        UIEdgeInsetsMake
        Hello, Swift!
        bubbleImageView / bubbleImageView / ...
        Hello, iOS!
        size(withAttributes:)
        stretchableImage
        imageView.image
        """
    ]
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func resetImages() {
    let circleFrame = CGRect(x: 10, y: 100, width: 100, height: 100)
    let flagFrame = CGRect(x: 105, y: 100, width: 140, height: 100)
    let bubbleFrame = CGRect(x: 240, y: 100, width: 120, height: 100)
    let labelFrame = CGRect(x: 250, y: 120, width: 100, height: 50)
    
    circleImageView.frame = circleFrame
    flagImageView.frame = flagFrame
    bubbleImageView.frame = bubbleFrame
    bubbleImageView.image = UIImage(named: "bubble")
    
    messageLabel.frame = labelFrame
    messageLabel.text = "Hello, Swift!\nHello, iOS!"
    messageLabel.font = UIFont.systemFont(ofSize: 17)
  }
  
  @IBAction func resizeCircleImage() {
    guard let image = circleImageView.image else { return }
    resetImages()
    
    let size = image.size
    let stretchedImage = image.stretchableImage(
        withLeftCapWidth: Int(size.width / 2),
        topCapHeight: Int(size.height / 2)
    )
    
    circleImageView.image = stretchedImage
    circleImageView.frame = CGRect(x: 30, y: 300, width: view.bounds.width - 100, height: 250)
  }
  
  @IBAction func resizeFlagImage() {
    guard let image = flagImageView.image else { return }
    resetImages()
    
    let size = CGSize(width: image.size.width * 0.3, height: image.size.height * 0.5)
    let edgeInset = UIEdgeInsetsMake(0, size.width + 4.3, 0, size.width + 4.3 )
//    UIEdgeInsetsMake(<#T##top: CGFloat##CGFloat#>, <#T##left: CGFloat##CGFloat#>, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
    
    let resizedImage = image.resizableImage(withCapInsets: edgeInset, resizingMode: .stretch)
    flagImageView.image = resizedImage
    flagImageView.frame = CGRect(x: 30, y: 300, width: view.frame.width - 100, height: 250)
  }
  
  @IBAction func resizeBubbleImage() {
    // 실습 코드
    
    resetImages()
    
    
    messageLabel.text = textList[3]
   
    
    let textSize = messageLabel.text?.size(withAttributes: [.font: messageLabel.font]) ?? .zero
    
    guard let image = bubbleImageView.image else { return }
    
    let edgeInset = UIEdgeInsetsMake(10, 70, 40, 10)
    let resizedImage = image.resizableImage(withCapInsets: edgeInset, resizingMode: .stretch)
    bubbleImageView.image = resizedImage
    bubbleImageView.frame = CGRect(x: 30, y: 300, width: textSize.width+50, height: textSize.height+40)
    
    messageLabel.frame.size = CGSize(width: textSize.width, height: textSize.height)
    messageLabel.center = bubbleImageView.center


    }
  
  @IBAction func noSlicingImage() {
    // 실습 코드
    
    resetImages()
    
    
    messageLabel.text = textList[3]
    
    
    let textSize = messageLabel.text?.size(withAttributes: [.font: messageLabel.font]) ?? .zero
    
    
    
    bubbleImageView.frame = CGRect(x: 30, y: 300, width: textSize.width+50, height: textSize.height+100)
    
    messageLabel.frame.size = CGSize(width: textSize.width, height: textSize.height)
    messageLabel.center = bubbleImageView.center
    messageLabel.center.y = messageLabel.center.y - 20
    

    }
  
}



