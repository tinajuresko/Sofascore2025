//
//  LeagueSection.swift
//  hw3
//
//  Created by Tina Jureško on 20.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

struct LeagueSection {
    let league: League
    let matches: [Event]
}

func groupedEvents() -> [LeagueSection] {
    let allEvents = Homework3DataSource().events()
    
    let grouped = Dictionary(grouping: allEvents, by: { $0.league?.id })
    
    return grouped.compactMap { (key, events) in
        if let leagueId = key {
            let league = allEvents.first { $0.league?.id == leagueId }?.league
            return LeagueSection(league: league!, matches: events.sorted { $0.startTimestamp < $1.startTimestamp })
        }
        return nil
    }
}

