//
//  MatchViewModel.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MatchViewModel {
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let eventTime = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        return dateFormatter.string(from: eventTime)
    }
    
    var timeStatusText: String {
        switch event.status {
        case .notStarted:
            return "-"
        case .inProgress:
            let currentTime = Int(Date().timeIntervalSince1970)
            let elapsedMinutes = (currentTime - event.startTimestamp) / 60
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
            return AppStyles.Colors.secondary ?? .gray
        }
    }
    
    var homeTeamName: String {
        return event.homeTeam.name
    }
    
    var awayTeamName: String {
        return event.awayTeam.name
    }
    
    var homeScore: String {
        guard let score = event.homeScore else { return event.status == .notStarted ? "" : "—"  }
        return "\(score)"
    }
    
    var awayScore: String {
        guard let score = event.awayScore else { return event.status == .notStarted ? "" : "—"  }
        return "\(score)"
    }
    
    var homeScoreColor: UIColor {
        switch event.status {
        case .inProgress, .halftime:
            return UIColor.red
        case .finished:
            return AppStyles.Colors.secondary ?? .gray
        default:
            return .clear
        }
    }
    
    var awayScoreColor: UIColor {
        switch event.status {
        case .inProgress, .halftime:
            return UIColor.red
        case .finished:
            return AppStyles.Colors.primary ?? .black
        default:
            return .clear
        }
    }
}
