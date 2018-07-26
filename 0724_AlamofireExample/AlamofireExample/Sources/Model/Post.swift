//
//  Post.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Foundation

struct Post: Decodable {
  let pk: Int
  let author: User
  let title: String
  let content: String
  var imageLink: String?
  var createdDate: String
  
  private enum CodingKeys: String, CodingKey {
    case pk
    case author
    case title
    case content
    case imageLink = "img_cover"
    case createdDate = "created_date"
  }
}
