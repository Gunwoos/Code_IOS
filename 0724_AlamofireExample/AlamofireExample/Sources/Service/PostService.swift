//
//  PostService.swift
//  AlamofireExample
//
//  Created by giftbot on 2018. 3. 27..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import Alamofire

protocol PostServiceType {
  func retrievePostList(completion: @escaping (Result<[Post]>) -> ())
  func createPost(title: String, content: String?, imageData: Data?, completion: @escaping (Result<Post>) -> ())
  func downloadImage(imgURL: String, completion: @escaping (UIImage?) -> ())
}

struct PostService: PostServiceType {
  func createPost(title: String, content: String?, imageData: Data?, completion: @escaping (Result<Post>) -> ()) {
    print("\n---------- [ createPost ] ----------\n")
    
    guard !title.isEmpty else { return completion(.error(PostError.missingParameter(param: "title"))) }
    guard let token = UserManager.token else { return completion(.error(ServiceError.invalidToken)) }
    guard let url = URL(string: API.Post.create),
      let urlRequest = try? URLRequest(url: url, method: .post, headers: ["Authorization": token])
      else { return completion(.error(ServiceError.invalidURL)) }
    
    let params: Parameters = [
      "title": title,
      "content": content ?? "",
    ]
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
      for (key, value) in params {
        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key as String)
      }
      if let data = imageData {
        multipartFormData.append(data, withName: "img_cover", fileName: "image.png", mimeType: "image/png")
      }
    }, with: urlRequest) { (encodingResult) in
      switch encodingResult {
      case .success(request: let upload, _, _):
        upload.responseData { (response) in
          switch response.result {
          case .success(let value):
            do {
              let post = try value.decode(Post.self)
              completion(.success(post))
            } catch {
              completion(.error(error))
            }
          case .failure(let error):
            completion(.error(error))
          }
        }
      case .failure(let error):
        completion(.error(error))
      }
    }
  }
  
  func retrievePostList(completion: @escaping (Result<[Post]>) -> ()) {
    Alamofire
      .request(API.Post.list)
      .validate()
      .responseData(completionHandler: { (response) in
        switch response.result {
        case .success(let value):
          do {
            let postList = try value.decode([Post].self)
            completion(.success(postList))
          } catch {
            completion(.error(error))
          }
        case .failure(let error):
          completion(.error(error))
        }
      })
  }
  
  func downloadImage(imgURL: String, completion: @escaping (UIImage?) -> ()) {
    guard let url = URL(string: imgURL) else { return }
    Alamofire
      .request(url)
      .validate()
      .responseData(completionHandler: { (response) in
        switch response.result {
        case .success(let value):
          let image = UIImage(data: value)
          completion(image)
        case .failure(_):
          completion(nil)
        }
      })
  }
}
