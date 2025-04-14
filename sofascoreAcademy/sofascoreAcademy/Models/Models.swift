//
//  Models.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.04.2025..
//

import Foundation

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
