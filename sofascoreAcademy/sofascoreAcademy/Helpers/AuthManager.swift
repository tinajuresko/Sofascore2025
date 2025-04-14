//
//  AuthManager.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 13.04.2025..
//

import Foundation
import KeychainAccess

struct AuthManager {
    static func isUserAuthorized() -> Bool {
        let name = UserDefaults.standard.string(forKey: "name")
        let keychain = Keychain(service: "com.academy")
        let token = keychain["token"]
        
        return name != nil && token != nil
    }
}
