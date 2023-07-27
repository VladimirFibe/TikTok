import Foundation

struct Creator: Codable, Hashable {
    let id: String
    let image: String
    let username: String
    let followers_count: Int
}
