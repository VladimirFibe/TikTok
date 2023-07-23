import Foundation

struct PostComment {
    let text: String
    let person: Person
    let date: Date
    
    static func mockCommetns() -> [PostComment] {
        
        let person = Person(id: UUID().uuidString, username: "macuser", avatar: nil)
        return [
            "This is cool",
            "This is rad"
        ].map{ PostComment(text: $0, person: person, date: Date()) }
    }
}
