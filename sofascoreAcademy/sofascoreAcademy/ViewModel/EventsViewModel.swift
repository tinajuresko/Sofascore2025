//
//  EventsViewModel.swift
//  hw3
//
//  Created by Tina Jureško on 27.03.2025..
//

import Foundation
import UIKit
import SnapKit

class EventsViewModel: ObservableObject {
    enum State {
        case idle
        case loaded([LeagueSection])
        case loading
        case error
    }
    @Published private(set) var state: State = .idle
    
    var sections: [LeagueSection] = []
    func loadSections() async {
       
        self.state = .loading
        do {
            let events = try await APIClient.getEvents(sport: SportSelectionManager.shared.selectedSport.urlSlug)
            sections = getLeagueSections(for: events)
            
            insertIntoDB(sections)
            
            if sections.isEmpty {
                self.state = .error
            } else {
                self.state = .loaded(self.sections)
            }
            
        } catch {
            self.state = .error
        }
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
    
    func insertIntoDB(_ sections: [LeagueSection]) {
        sections.forEach { section in
            let league = section.league
            let leagueEntity = DBLeague(from: league)
            try? DbManager.shared.dbQueue?.write { db in
                try? leagueEntity.upsert(db)
            }
            
            let events = section.matches
            events.forEach { event in
                let eventEntity = DBEvent(from: event)
                try? DbManager.shared.dbQueue?.write { db in
                    try? eventEntity.upsert(db)
                }
            }
        }
    }
}

