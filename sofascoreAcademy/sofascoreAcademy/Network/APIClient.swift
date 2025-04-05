//
//  APIClient.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.04.2025..
//

import Foundation
import Network

enum APIClient {
    static func getEvents(sport: String) async throws -> [Event] {
        let urlString = "https://sofa-ios-academy-43194eec0621.herokuapp.com/events?sport=\(sport)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NSError(domain: "Invalid response", code: 400, userInfo: nil)
            }
            
            let events = try JSONDecoder().decode([Event].self, from: data)
            return events
        } catch {
            throw error
        }
    }
}

