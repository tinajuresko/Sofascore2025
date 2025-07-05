//
//  TournamentStandingsViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 02.06.2025..
//

import Foundation
import Combine

class TournamentStandingsViewModel: ObservableObject {
    @Published private(set) var state: State<[Standings]> = .idle
    private let leagueId: Int
    var standings: [Standings] = []

    init(leagueId: Int) {
        self.leagueId = leagueId
    }

    func loadTournamentStandings() {
        Task {
            self.state = .loading
            do {
                standings = try await APIClient.getLeagueStandings(forLeagueId: leagueId)
                
                if standings.isEmpty {
                    self.state = .error
                } else {
                    self.state = .loaded(self.standings)
                }
                
            } catch {
                self.state = .error
            }
        }
    }
}
