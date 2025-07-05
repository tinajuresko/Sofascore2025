//
//  EventDetailsViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 10.04.2025..
//

import Foundation
import UIKit

struct EventDetailsViewModel {
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    var id: Int {
        return event.id
    }
    
    var status: EventStatus {
        return event.status
    }

    var time: String {
        return event.startTimestamp.asDate.hourMinute
    }
    
    var homeTeamId: Int {
        return event.homeTeam.id
    }
    
    var homeTeamName: String {
        return event.homeTeam.name
    }
    
    var awayTeamId: Int {
        return event.awayTeam.id
    }
    
    var awayTeamName: String {
        return event.awayTeam.name
    }
    
    var homeTeamLogo: String? {
        return event.homeTeam.logoUrl
    }
        
    var awayTeamLogo: String? {
        return event.awayTeam.logoUrl
    }
    
    var homeScore: String {
        guard let score = event.homeScore else {
            return event.status == .notStarted ? "" : "—"
        }
        return "\(score)"
    }
    
    var awayScore: String {
        guard let score = event.awayScore else {
            return event.status == .notStarted ? "" : "—"
        }
        return "\(score)"
    }
    
    var homeScoreColor: UIColor {
        switch event.status {
        case .inProgress, .halftime:
            return UIColor.red
        case .finished:
            return .secondaryGray
        default:
            return .clear
        }
    }
    
    var awayScoreColor: UIColor {
        switch event.status {
        case .inProgress, .halftime:
            return UIColor.red
        case .finished:
            return .primaryBlack
        default:
            return .clear
        }
    }
    
    var league: League? {
        return event.league
    }
    
    var eventDetailsText: String? {
        switch event.status {
        case .notStarted:
            return event.startTimestamp.asDate.dayMonthYear
        default:
            return nil
        }
    }
    
    var eventDetailsStatusText: String {
        switch event.status {
        case .notStarted:
            return "\(time)"
        case .inProgress:
            let elapsedMinutes = Date().elapsedMinutes(from: event.startTimestamp.asDate)
            return "\(elapsedMinutes)'"
        case .halftime:
            return "Half Time"
        default:
            return "Full Time"
        }
    }
    
    var eventDetailsStatusColor: UIColor {
        switch event.status {
        case .inProgress, .halftime:
            return UIColor.red
        case .notStarted:
            return .primaryBlack
        default:
            return .secondaryGray
        }
    }
    
    var scoresText: NSAttributedString {
        let separator = " - "
        let homeScoreAttr = NSAttributedString(
            string: homeScore,
            attributes: [.foregroundColor: homeScoreColor]
        )
        let separatorColor: UIColor = (homeScoreColor == .red && awayScoreColor == .red) ? .red : .secondaryGray
        let separatorAttr = NSAttributedString(
            string: separator,
            attributes: [.foregroundColor: separatorColor]
        )
        let awayScoreAttr = NSAttributedString(
            string: awayScore,
            attributes: [.foregroundColor: awayScoreColor]
        )
        let combined = NSMutableAttributedString()
        combined.append(homeScoreAttr)
        combined.append(separatorAttr)
        combined.append(awayScoreAttr)
        
        return combined
    }
    
    var incidentPeriods: [[Incident]] {
        guard let incidents = event.incidents else { return [] }
        return splitIncidentsByPeriod(incidents)
    }

    func splitIncidentsByPeriod(_ incidents: [Incident]) -> [[Incident]] {
        var result: [[Incident]] = []
        var currentPeriod: [Incident] = []

        for incident in incidents {
            currentPeriod.append(incident)
            if incident.type == .periodEnd {
                result.append(currentPeriod)
                currentPeriod = []
            }
        }

        if !currentPeriod.isEmpty {
            result.append(currentPeriod)
        }

        return result
    }
}
