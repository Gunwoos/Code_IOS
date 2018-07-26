
struct Cards: Codable {
  let state: String
  var cards: [Card]
}

struct Card: Codable {
  let name: String
  let image: String
}
