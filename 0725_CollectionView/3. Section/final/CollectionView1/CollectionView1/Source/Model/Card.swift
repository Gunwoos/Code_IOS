
struct Cards: Codable {
  let state: String
  let cards: [Card]
}

struct Card: Codable {
  let name: String
  let image: String
}
