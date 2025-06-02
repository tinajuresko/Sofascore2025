//
//  TournamentMatchesViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import Combine

class TournamentMatchesViewModel: ObservableObject {
    @Published private(set) var groupedMatches: [Int: [Event]] = [:]
    @Published private(set) var state: State<[Event]> = .idle
    private let leagueId: Int
    var events: [Event] = []

    init(leagueId: Int) {
        self.leagueId = leagueId
    }

    func loadTournamentMatches() {
        Task {
            self.state = .loading
            do {
                events = try await APIClient.getLeagueMatches(forLeagueId: leagueId)
                
                if events.isEmpty {
                    self.state = .error
                } else {
                    self.state = .loaded(self.events)
                }
                
                let grouped = Dictionary(grouping: events) { $0.round ?? 0 }
                let sortedGrouped = grouped.sorted { $0.key < $1.key }
                groupedMatches = Dictionary(uniqueKeysWithValues: sortedGrouped)
                
            } catch {
                self.state = .error
            }
        }
    }
}
