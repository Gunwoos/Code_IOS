import Foundation

struct ImageService {
  
  static func image(completion: (Result<[Cards]>) -> Void) {
    let url = Bundle.main.url(forResource: "data", withExtension: "json")!
    
    do {
      let data = try Data(contentsOf: url)
      let images = try JSONDecoder().decode([Cards].self, from: data)
      let result = Result<[Cards]>.success(images)
      completion(result)
    } catch {
      let result = Result<[Cards]>.failure(error)
      completion(result)
    }
  }
}
