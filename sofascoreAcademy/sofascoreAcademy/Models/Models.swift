//
//  Models.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.04.2025..
//

import Foundation
import GRDB

struct EventsContainer: Decodable {
    public let events: [Event]
}

struct Team: Decodable {
    public let id: Int
    public let name: String
    public let logoUrl: String
}

struct Country: Decodable {
    public let id: Int
    public let name: String
}

struct League: Decodable {
    public let id: Int
    public let name: String
    public let country: Country?
    public let logoUrl: String?
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

struct Event: Decodable {
    public let id: Int
    public let homeTeam: Team
    public let awayTeam: Team
    public let startTimestamp: Int
    public let status: EventStatus
    public let league: League?
    public let homeScore: Int?
    public let awayScore: Int?
}

struct LoginRequest: Codable {
    public let username: String
    public let password: String
}

struct LoginResponse: Codable {
    public let name: String
    public let token: String
}

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
