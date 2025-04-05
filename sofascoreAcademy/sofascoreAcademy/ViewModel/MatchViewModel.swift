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
        case .NOT_STARTED:
            return "-"
        case .IN_PROGRESS:
            let currentTime = Int(Date().timeIntervalSince1970)
            let elapsedMinutes = (currentTime - event.startTimestamp) / 60
            return "\(elapsedMinutes)'"
        case .FINISHED:
            return "FT"
        case .HALF_TIME:
            return "HT"
        }
    }
    
    var timeStatusColor: UIColor {
        switch event.status {
        case .IN_PROGRESS:
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
            return event.status == .NOT_STARTED ? "" : "—"
        }
        return "\(score)"
    }
    
    var awayScore: String {
        guard let score = event.awayScore else {
            return event.status == .NOT_STARTED ? "" : "—"
        }
        return "\(score)"
    }
    
    var homeScoreColor: UIColor {
        switch event.status {
        case .IN_PROGRESS, .HALF_TIME:
            return UIColor.red
        case .FINISHED:
            return .secondaryGray
        default:
            return .clear
        }
    }
    
    var awayScoreColor: UIColor {
        switch event.status {
        case .IN_PROGRESS, .HALF_TIME:
            return UIColor.red
        case .FINISHED:
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
        case .NOT_STARTED:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let eventDate = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
            let formattedDate = dateFormatter.string(from: eventDate)
            return formattedDate
        default:
            return nil
        }
    }
    
    var eventDetailsStatusText: String {
        switch event.status {
        case .NOT_STARTED:
            return "\(time)"
        case .IN_PROGRESS:
            let currentTime = Int(Date().timeIntervalSince1970)
            let elapsedMinutes = (currentTime - event.startTimestamp) / 60
            return "\(elapsedMinutes)'"
        case .HALF_TIME:
            return "Half Time"
        default:
            return "Full Time"
        }
    }
    
    var eventDetailsStatusColor: UIColor {
        switch event.status {
        case .IN_PROGRESS, .HALF_TIME:
            return UIColor.red
        case .NOT_STARTED:
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
        let separatorColor: UIColor = (homeScoreColor == .red && awayScoreColor == .red) ? .red : .primaryBlack
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
}
