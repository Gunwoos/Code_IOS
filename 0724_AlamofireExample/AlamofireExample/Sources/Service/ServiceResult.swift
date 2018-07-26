//
//  ServiceResult.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case error(Error)
}

enum ServiceError: Error {
  case invalidToken
  case invalidURL
  case parsingError
}

enum PostError: Error {
  case missingParameter(param: String)
  case encodingError
}

enum AuthError: Error {
  case invalidUsername
  case invalidPassword
}
