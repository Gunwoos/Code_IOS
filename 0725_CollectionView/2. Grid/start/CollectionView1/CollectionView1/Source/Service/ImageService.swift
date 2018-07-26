import Foundation

struct ImageService {
  
  static func image(completion: (Result<[Card]>) -> Void) {
    let url = Bundle.main.url(forResource: "data", withExtension: "json")!
    
    do {
      let data = try Data(contentsOf: url)
      let images = try JSONDecoder().decode([Card].self, from: data)
      let result = Result<[Card]>.success(images)
      completion(result)
    } catch {
      let result = Result<[Card]>.failure(error)
      completion(result)
    }
  }
}
