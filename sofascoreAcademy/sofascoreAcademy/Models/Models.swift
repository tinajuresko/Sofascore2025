//
//  Models.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.04.2025..
//

import Foundation
import UIKit
import GRDB

struct Team: Decodable {
    public let id: Int
    public let name: String
    public let logoUrl: String
    public let country: Country?
}

struct Country: Decodable {
    public let name: String
}

struct League: Decodable {
    public let id: Int
    public let name: String
    public let country: Country?
    public let logoUrl: String
    public let seasonId: Int
}

enum EventStatus: String, Decodable {
    case notStarted
    case inProgress
    case halftime
    case finished
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self).lowercased()
        
        switch rawValue {
        case "not_started":
            self = .notStarted
        case "in_progress":
            self = .inProgress
        case "halftime":
            self = .halftime
        default:
            self = .finished
        }
    }
}

enum IncidentType: String, Decodable {
    case goal
    case redCard
    case yellowCard
    case periodEnd
    case foul
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self).lowercased()
        
        switch rawValue {
        case "goal":
            self = .goal
        case "red_card":
            self = .redCard
        case "yellow_card":
            self = .yellowCard
        case "period_end":
            self = .periodEnd
        default:
            self = .foul
        }
    }
    
    var incidentIcon: UIImage? {
        IncidentIconProvider.icon(for: self, sport: SportSelectionManager.shared.selectedSport)
    }
}

struct Incident: Decodable, Equatable {
    public let type: IncidentType
    public let minute: Int
    public let isHomeTeam: Bool?
    public let extraMinute: Int?
    public let player: String?
    public let scoreDiff: Int?
    public let score: String?
    public let description: String?
}

struct Event: Decodable {
    public let id: Int
    public let homeTeam: Team
    public let awayTeam: Team
    public let startTimestamp: Int
    public let status: EventStatus
    public let league: League?
    public let homeScore: Int?
    public let awayScore: Int?
    public let round: Int?
    public let incidents: [Incident]?
}

struct LoginRequest: Codable {
    public let username: String
    public let password: String
}

struct LoginResponse: Codable {
    public let name: String
    public let token: String
}

struct Standings: Decodable {
    public let team: Team
    public let position: Int
    public let matches: Int
    public let wins: Int
    public let losses: Int
    public let draws: Int
    public let points: Int?
    public let percentage: Double?
    public let scoreFor: Int?
    public let scoreAgainst: Int?
    public let scoreFormatted: String?
}

struct TeamManager: Decodable {
    public let id: Int
    public let name: String
    public let country: Country?
    public let imageUrl: String
}

struct TeamVenueCity: Decodable {
    public let name: String
}

struct TeamVenue: Decodable {
    public let name: String
    public let capacity: Int?
    public let city: TeamVenueCity?
}

struct TeamInfo: Decodable {
    public let team: Team
    public let manager: TeamManager?
    public let venue: TeamVenue?
}

struct Player: Decodable {
    public let id: Int
    public let name: String?
    public let shortName: String?
    public let position: String?
    public let jerseyNumber: String?
    public let country: Country?
    public let imageUrl: String
    public let isForeign: Bool?
}

// Database models
struct DBLeague: Codable, FetchableRecord, PersistableRecord {
    let id: Int
    let name: String
    let countryName: String?
    let logoUrl: String?
    
    init(from league: League) {
        self.id = league.id
        self.name = league.name
        self.countryName = league.country?.name
        self.logoUrl = league.logoUrl
    }
}

struct DBEvent: Codable, FetchableRecord, PersistableRecord {
    let id: Int
    let homeTeam: String
    let awayTeam: String
    let startTimestamp: Int
    let status: String
    let homeScore: Int?
    let awayScore: Int?
    let leagueId: Int?
    
    init(from event: Event) {
        self.id = event.id
        self.homeTeam = event.homeTeam.name
        self.awayTeam = event.awayTeam.name
        self.startTimestamp = event.startTimestamp
        self.status = event.status.rawValue
        self.homeScore = event.homeScore
        self.awayScore = event.awayScore
        self.leagueId = event.league?.id 
    }
}
