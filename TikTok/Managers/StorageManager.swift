import Foundation
import FirebaseStorage

final class StorageManager {
    public static let share = StorageManager()
    
    private let database = Storage.storage().reference()
    
    private init() {}
    
    public func getVideoURL(with identifier: String, completion: (URL) -> Void) {
        
    }
    
    public func uploadVideoURL(from url: URL) {
        
    }
}
