//
//  Data+Decode.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Foundation

extension Data {
  func decode<T>(_ type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Decodable {
    return try decoder.decode(type, from: self)
  }
}
