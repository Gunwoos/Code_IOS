//
//  AuthService.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Alamofire

protocol AuthServiceType {
  func signIn(username: String, password: String, completion: @escaping (Result<User>) -> ())
  func signUp(username: String, password: String, completion: @escaping (Result<User>) -> ())
}

struct AuthService: AuthServiceType {
  func signIn(username: String, password: String, completion: @escaping (Result<User>) -> ()) {
    requestService(url: API.Auth.signIn, username: username, password: password, completion: completion)
  }
  
  func signUp(username: String, password: String, completion: @escaping (Result<User>) -> ()) {
    requestService(url: API.Auth.signUp, username: username, password: password, completion: completion)
  }
  
  func requestService(url: String, username: String, password: String, completion: @escaping (Result<User>) -> ()) {
    guard !username.isEmpty else { return completion(.error(AuthError.invalidUsername)) }
    guard !password.isEmpty else { return completion(.error(AuthError.invalidPassword)) }
    
    let params: Parameters = [
      "username": username,
      "password": password
    ]
    
    Alamofire.request(url, method: .post, parameters: params)
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success(let value):
          do {
            let user = try value.decode(User.self)
            completion(.success(user))
          } catch {
            completion(.error(error))
          }
        case .failure(let error):
          completion(.error(error))
        }
    }
  }
}

