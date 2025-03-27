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

struct EventsViewModel {
    var sections: [LeagueSection] = []
    
    func getLeagueSections(allEvents: [Event]) -> [LeagueSection] {
        
        let grouped = Dictionary(grouping: allEvents, by: { $0.league?.id })
        
        return grouped.compactMap { (key, events) in
            guard let league = events.first?.league else {
                return nil
            }
            return LeagueSection(league: league, matches: events.sorted { $0.startTimestamp < $1.startTimestamp })
        }
    }

    
}

