//
//  Constants.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Foundation

enum API {
  static let baseURL = "https://api.lhy.kr/"
  
  enum Auth {
    static let signUp = API.baseURL + "members/signup/"
    static let signIn = API.baseURL + "members/auth-token/"
    static let userDetail = API.baseURL + "members/profile/"
  }
  enum Post {
    static let list = API.baseURL + "posts/"
    static let create = API.baseURL + "posts/"
  }
}
