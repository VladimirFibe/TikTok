import Foundation

struct PostModel {
    let id: String
    var isLikedByCurrentUser = false
    static func mockModels() -> [PostModel] {
        (0..<10).map { _ in PostModel(id: UUID().uuidString) }
    }
}
