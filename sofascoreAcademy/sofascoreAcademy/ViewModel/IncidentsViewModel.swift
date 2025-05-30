//
//  IncidentsViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 27.05.2025..
//

import Foundation
import UIKit
import SnapKit

class IncidentsViewModel: ObservableObject {
    @Published private(set) var state: State<[Incident]> = .idle
    let eventId: Int
    @MainActor var onIncidentsLoaded: (([Incident]) -> Void)?
    var incidents: [Incident] = []
    
    init(eventId: Int) {
        self.eventId = eventId
    }

    func loadIncidents() {
        Task {
            self.state = .loading
            do {
                incidents = try await APIClient.getIncidents(forEventId: eventId)
                await onIncidentsLoaded?(incidents)
                
                if incidents.isEmpty {
                    self.state = .error
                } else {
                    self.state = .loaded(self.incidents)
                }
            } catch {
                self.state = .error
            }
        }
    }
}
