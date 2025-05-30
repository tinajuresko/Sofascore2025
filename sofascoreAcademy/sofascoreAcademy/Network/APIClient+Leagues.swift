//
//  APIClient+Leagues.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 27.05.2025..
//

import Foundation
import Network

extension APIClient {
    static func getLeague(by id: Int) async throws -> League {
        return try await fetch(
            path: "/leagues/\(id)"
        )
    }
    
    static func getLeagueMatches(forLeagueId id: Int) async throws -> [Event] {
        return try await fetch(
            path: "/leagues/\(id)/matches"
        )
    }
    
    static func getLeagueStandings(forLeagueId id: Int) async throws -> [Standings] {
        return try await fetch(
            path: "/leagues/\(id)/standings"
        )
    }
}
