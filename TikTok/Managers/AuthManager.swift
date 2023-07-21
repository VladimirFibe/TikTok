//
//  AuthManager.swift
//  TikTok
//
//  Created by Vladimir Fibe on 21.07.2023.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    public static let shared = AuthManager()
    
    private init() {}
    
    enum SignInMethod {
        case email
        case facebook
        case google
    }
    
    public func signIn(with method: SignInMethod) {
        
    }
    
    public func signOut() {
        
    }
}
