//
//  APIClient+Login.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 14.04.2025..
//

import Foundation
import Network

extension APIClient {
    static func login(username: String, password: String) async throws -> LoginResponse {
        let requestBody = LoginRequest(username: username, password: password)
        let jsonData = try JSONEncoder().encode(requestBody)
        let response: LoginResponse = try await fetch(
            path: "/login",
            method: "POST",
            body: jsonData
        )
        return response
    }
}
