//
//  LoginViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 12.04.2025..
//

import Foundation
import UIKit

struct LoginViewModel {
    var onLoginResponse: ((String) -> Void)?
    
    func login(username: String?, password: String?) async {
        guard let safeUsername = username,
              let safePassword = password,
              !safeUsername.isEmpty,
              !safePassword.isEmpty
        else {
            onLoginResponse?("Please enter your username and password")
            return
        }
            
        do {
            let response = try await APIClient.login(username: safeUsername, password: safePassword)
            UserDefaults.standard.set(response.name, forKey: KeysManager.userDefaultsKey)
            KeychainManager.shared.save(response.token, forKey: KeysManager.keychainKey)
            
            onLoginResponse?("")
        } catch {
            onLoginResponse?("Username or password incorrect. Please check your credentials.")
        }
    }
}
