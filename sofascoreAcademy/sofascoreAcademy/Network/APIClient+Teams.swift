//
//  APIClient+Teams.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 27.05.2025..
//

import Foundation
import Network

extension APIClient {
    static func getTeam(by id: Int) async throws -> TeamInfo {
        return try await fetch(
            path: "/teams/\(id)"
        )
    }
    
    static func getTeamPlayers(forTeamId id: Int) async throws -> [Player] {
        return try await fetch(
            path: "/teams/\(id)/players"
        )
    }
    
    static func getTeamTournaments(forTeamId id: Int) async throws -> [League] {
        return try await fetch(
            path: "/teams/\(id)/tournaments"
        )
    }
}
