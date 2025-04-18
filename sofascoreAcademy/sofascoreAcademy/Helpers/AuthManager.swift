//
//  AuthManager.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 13.04.2025..
//

import Foundation

struct AuthManager {
    static func isUserAuthorized() -> Bool {
        let name = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey)
        let token = KeychainManager.shared.read(forKey: KeysManager.keychainKey)
        
        return name != nil && token != nil
    }
}
