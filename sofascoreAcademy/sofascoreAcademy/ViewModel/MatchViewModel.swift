//
//  MatchViewModel.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit
import SnapKit

struct MatchViewModel {
    let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    var time: String {
        return event.startTimestamp.asDate.hourMinute
    }
    
    var timeStatusText: String {
        switch event.status {
        case .notStarted:
            return "-"
        case .inProgress:
            let elapsedMinutes = Date().elapsedMinutes(from: event.startTimestamp.asDate)
            return "\(elapsedMinutes)'"
        case .finished:
            return "FT"
        case .halftime:
            return "HT"
        }
    }
    
    var timeStatusColor: UIColor {
        switch event.status {
        case .inProgress:
            return .red
        default:
            return .secondaryGray
        }
    }
    
    var homeTeamName: String {
        return event.homeTeam.name
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
}
