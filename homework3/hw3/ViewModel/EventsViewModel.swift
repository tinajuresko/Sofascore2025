//
//  EventsViewModel.swift
//  hw3
//
//  Created by Tina Jureško on 27.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class EventsViewModel {
    var sections: [LeagueSection] = []
    func loadSections() async {
        let events = Homework3DataSource().events()
        sections = getLeagueSections(for: events)
    }
    
    func getLeagueSections(for events: [Event]) -> [LeagueSection] {
        
        let grouped = Dictionary(grouping: events, by: { $0.league?.id })
        
        return grouped.compactMap { (leagueId, events) in
            guard let league = events.compactMap({ $0.league }).first(where: { $0.id == leagueId }) else {
                return nil
            }
            return LeagueSection(league: league, matches: events.sorted { $0.startTimestamp < $1.startTimestamp })
        }
    }
}

