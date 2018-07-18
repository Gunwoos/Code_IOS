//
//  ViewController.swift
//  0717_cocoapod
//
//  Created by 임건우 on 2018. 7. 17..
//  Copyright © 2018년 lims. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import Hero

class ViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Alamofire.request(imageUrl)
//        .validate()
//            .responseData { (response) in
//                switch response.result {
//                case .success(let value):
//                    self.imageView.image = UIImage(data: value)
//                case .failure(let error):
//                    print(error)
//                }
        
        
        imageView.kf.setImage(with: imageUrl)
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

