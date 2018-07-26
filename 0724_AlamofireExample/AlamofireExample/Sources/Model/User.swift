//
//  User.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Foundation

struct User: Decodable {
  let pk: Int
  let username: String
  var firstName: String?
  var lastName: String?
  var email: String?
  
  enum CodingKeys: String, CodingKey {
    case user
    case token
  }
  
  enum AdditionalInfoKeys: String, CodingKey {
    case pk
    case username
    case firstName = "first_name"
    case lastName = "last_name"
    case email
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let token = try values.decodeIfPresent(String.self, forKey: .token)
    
    let userDict: KeyedDecodingContainer<User.AdditionalInfoKeys>
    if token != nil {
      UserManager.token = token
      userDict = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .user)
    } else {
      userDict = try decoder.container(keyedBy: AdditionalInfoKeys.self)
    }
    
    pk = try userDict.decode(Int.self, forKey: .pk)
    username = try userDict.decode(String.self, forKey: .username)
    firstName = try userDict.decodeIfPresent(String.self, forKey: .firstName)
    lastName = try userDict.decodeIfPresent(String.self, forKey: .lastName)
    email = try userDict.decodeIfPresent(String.self, forKey: .email)
  }
}
