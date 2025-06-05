//
//  TeamViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.06.2025..
//

import Foundation
import Combine

class TeamViewModel: ObservableObject {
    @Published private(set) var state: State<(TeamInfo?, [Player], [League])> = .idle
    @Published var teamInfo: TeamInfo?
    @Published var players: [Player] = []
    @Published var tournaments: [League] = []
    private let teamId: Int

    init(teamId: Int) {
        self.teamId = teamId
    }

    func loadTeam() {
        Task {
            self.state = .loading
            do {
                self.teamInfo = try await APIClient.getTeam(by: teamId)
                self.players = try await APIClient.getTeamPlayers(forTeamId: teamId)
                self.tournaments = try await APIClient.getTeamTournaments(forTeamId: teamId)

                if teamInfo == nil || players.isEmpty || tournaments.isEmpty {
                    self.state = .error
                } else {
                    self.state = .loaded((self.teamInfo, self.players, self.tournaments))
                }
                
            } catch {
                print("Error loading team: \(error)")
                self.state = .error
            }
        }
    }
}
