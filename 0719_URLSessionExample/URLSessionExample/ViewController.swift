//
//  ViewController.swift
//  URLSessionExample
//
//  Created by giftbot on 2018. 3. 21..
//  Copyright © 2018년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  var mySession: URLSession?
  
  
  // MARK: - Sync method
  
  @IBAction private func syncMethod() {
    print("\n---------- [ syncMethod ] ----------\n")
    
    let url = URL(string: "http://lorempixel.com/860/640/cats/")!
    
    if let data = try? Data(contentsOf: url) {
      print("image downloaded")
      self.imageView.image = UIImage(data: data)
    }
    
    /***************************************************
     Don't use this synchronous method to request network-based URLs.
     For network-based URLs, this method can block the current thread for tens of seconds on a slow network,
     resulting in a poor user experience, and in iOS, may cause your app to be terminated.
     ***************************************************/
  }
  
  
  
  // MARK: - URL Encoding Example
  
  @IBAction private func urlEncodingExample() {
    print("\n---------- [ urlEncodingExample ] ----------\n")
    
    // String To URL
    let originalString = "color-#708090"
    let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
    print(encodedString!) // prints "color-%23708090"
    
    // URL To String
    let url = URL(string: "https://example.com/#color-%23708090")!
    let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    let fragment = components.fragment!
    print(fragment) // prints "color-#708090"
    
    // 한글 주소
    let urlString = "https://search.naver.com/search.naver?query=한글"
    if let url = URL(string: urlString) {
      print(url)
    } else {
      print("Nil")
    }
    
    // Query 부분 변환
    let str = "https://search.naver.com/search.naver?query=한글"
    let queryEncodedStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let convertedURL = URL(string: queryEncodedStr)!
    print(convertedURL)  // %ED%95%9C%EA%B8%80
    
// http://username:password@www.example.com/index.html?key=1&value=2#frag
// CharacterSet.urlUserAllowed
// CharacterSet.urlPasswordAllowed
// CharacterSet.urlHostAllowed
// CharacterSet.urlPathAllowed
// CharacterSet.urlQueryAllowed
// CharacterSet.urlFragmentAllowed
    
    /***************************************************
     URL 문자열의 percent-encode 부분을 위해 addingPercentEncoding 메서드 활용
     URL component or subcomponent 를 위해 적절한 캐릭터셋을 전달
     주의! : 전체 URL string 에다가 Encoding 을 적용하면 안 됨.
     각각의 URL component 와 subcomponent 는 유효한 문자열에 대한 다른 규칙을 가지고 있을 수 있음
     ***************************************************/
  }
  
  
  
  // MARK: - Session Configuration
  
  @IBAction private func sessionConfig(_ sender: Any) {
    /***************************************************
     backgroundConfiguration 을 제외하고 다른 둘은 다른 세션을 추가 생성할 때 재사용이 가능
     (백그라운드는 동일 식별자를 공유하는 두 개의 백그라운드 세션 객체의 동작이 정의되어 있지 않으므로 재사용 불가)
     
     Session 구성 시 configuration 객체의 값을 Deep Copy(깊은 복사) 하기 때문에 세션 생성 이후 값을 변경해도
     기존 세션에는 영향을 주지 않고 새 세션에만 적용 가능
     한 번 세션을 구성하고 나면 해당 세션은 configuration 이나 delegate 를 변경할 수 없으므로 새로 생성해야 함.
     ***************************************************/
    
    _ = URLSessionConfiguration.default
    _ = URLSessionConfiguration.ephemeral
    _ = URLSessionConfiguration.background(withIdentifier: "kr.giftbot.example.backgroundConfig")
    // 싱글톤
    
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.allowsCellularAccess = false  // 기본값 true. Wi-Fi 만 가능하도록 하고 싶을 때
    sessionConfig.urlCache = URLCache.shared
    
    /***************************************************
     URLCache.shared 기본 캐시 설정
     - Memory capacity: 4 megabytes (4 * 1024 * 1024 bytes)
     - Disk capacity: 20 megabytes (20 * 1024 * 1024 bytes)
     - Disk path: (user home directory)/Library/Caches/(application bundle id)
     - URLCache.shared - 특별한 캐싱 요구 사항이나 제한 조건이 없는 앱은 기본 공유 캐시 인스턴스를 사용.
     ***************************************************/
    
    sessionConfig.urlCache = {
      let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
      let cachePath = cacheDir.appendingPathComponent("MyCache")
      // 16 KB (16 * 1024 = 16384), 256 MB (256 * 1024 * 1024 = 268435456)
      let cache = URLCache(memoryCapacity: 16384, diskCapacity: 268435456, diskPath: cachePath.path)
      return cache
    }()
    
    sessionConfig.requestCachePolicy = .useProtocolCachePolicy
    
    /***************************************************
     • reloadIngoringLocalCacheData
       - 로컬 캐시 파일은 완전히 무시하고 항상 원본 소스에 접근 
     • returnCacheDataDontLoad
       - 로컬 캐시 파일만 취급하여 네트워크 연결을 하지 않으며 Offline 모드와 유사하게 동작
       - URLSessionTask 객체에서 이 정책으로 요청을 보냈는데 캐시 파일이 없을 경우 바로 nil 반환.  
     • returnCacheDataElseLoad
       - 로컬 캐시 파일부터 읽어 보고 만료 기간이 지났을 경우 원본 소스에 접근 
     • useProtocolCachePolicy
       - 각 프로토콜별 정책에 따름
     
     아래 2개는 Swift에서 미구현된 정책이므로 사용하지 말 것
     - reloadIgnoringLocalAndRemoteCacheData
     - reloadRevalidatingCacheData
     ***************************************************/
    
    
    // 위에서 설정한 Session Configuration 반영
    
    mySession = URLSession(configuration: sessionConfig)
    let url = URL(string: "http://www.catster.com/wp-content/uploads/2017/08/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg")!
    let task = mySession?.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self?.imageView.image = UIImage(data: data)!
        print("download completed")
      }
    })
    task?.resume()
  }
  
  
  // MARK: - URLRequest
  
  @IBAction private func urlRequest(_ sender: Any) {
    print("\n---------- [ urlRequest ] ----------\n")
    makeGetCall()
    makePostCall()
    makeDeleteCall()
    }
  
  
  func makeGetCall() {
    let todoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    guard let url = URL(string: todoEndpoint) else {
      return print("Error: cannot create URL")
    }
    let urlRequest = URLRequest(url: url)
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: urlRequest) { (data, response, error) in
      guard error == nil else { return print(error!) }
      guard let data = data else { return print("Error: did not receive data") }
      
      do {
        guard let todo = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let todoTitle = todo["title"] as? String
          else { return }
        print(todo)
        print("Title :", todoTitle)
      } catch  {
        print("error trying to convert data to JSON")
        return
      }
    }
    task.resume()
  }
  
  func makePostCall() {
    // 작업 시 데이터를 숨겨서 보내야할 때 POST 방식 사용
    let todosEndpoint = "https://jsonplaceholder.typicode.com/todos"
    guard let todosURL = URL(string: todosEndpoint) else {
      return print("Error: cannot create URL")
    }
    
    let newTodo: [String: Any] = ["title": "My First todo", "completed": false, "userId": 1]
    guard let jsonTodo = try? JSONSerialization.data(withJSONObject: newTodo) else { return }
    
    var todosUrlRequest = URLRequest(url: todosURL)
    todosUrlRequest.httpMethod = "POST"
    todosUrlRequest.httpBody = jsonTodo
    
    let session = URLSession.shared
    let task = session.dataTask(with: todosUrlRequest) { (data, response, error) in
      guard error == nil else { return print(error!) }
      guard let data = data else { return print("Error: did not receive data") }
      
      do {
        guard let receivedTodo = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let todoID = receivedTodo["id"] as? Int
          else { return print("Could not get JSON from responseData as dictionary") }
        
        print(receivedTodo)
        print("The ID is: \(todoID)")
      } catch  {
        print("error parsing response from POST on /todos")
        return
      }
    }
    task.resume()
  }
  
  func makeDeleteCall() {
    let firstTodoEndpoint = "https://jsonplaceholder.typicode.com/todos/1"
    let url = URL(string: firstTodoEndpoint)!
    var firstTodoUrlRequest = URLRequest(url: url)
    firstTodoUrlRequest.httpMethod = "DELETE"
    
    let task = URLSession.shared.dataTask(with: firstTodoUrlRequest) { (data, response, error) in
      guard error == nil else { return print(error!) }
      guard let _ = data else { return print("Error: did not receive data") }
      print("DELETE ok")
    }
    task.resume()
  }
}

