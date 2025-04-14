//
//  APIClient+Events.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 14.04.2025..
//

import Foundation
import Network

extension APIClient {
    static func getEvents(sport: String) async throws -> [Event] {
        return try await fetch(
            path: "/secure/events",
            queryItems: [URLQueryItem(name: "sport", value: sport)]
        )
    }
}
