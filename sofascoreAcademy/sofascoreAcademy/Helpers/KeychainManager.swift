//
//  KeychainManager.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 18.04.2025..
//

import Foundation
import KeychainAccess

final class KeychainManager {
    static let shared = KeychainManager()
    private let keychain: Keychain
    
    private init() {
        self.keychain = Keychain(service: "com.academy")
    }
    
    func save(_ value: String, forKey key: String) {
        keychain[key] = value
    }
    
    func read(forKey key: String) -> String? {
        return keychain[key]
    }
    
    func delete(forKey key: String) {
        try? keychain.remove(key)
    }
}
