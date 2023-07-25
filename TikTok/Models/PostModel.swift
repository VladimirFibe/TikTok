import Foundation

struct PostModel {
    let id: String
    let person = Person(id: UUID().uuidString, username: "macuser", avatar: nil)
    var isLikedByCurrentUser = false
    static func mockModels() -> [PostModel] {
        (0..<10).map { _ in PostModel(id: UUID().uuidString) }
    }
}
