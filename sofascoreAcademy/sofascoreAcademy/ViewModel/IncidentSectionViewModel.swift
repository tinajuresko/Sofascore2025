//
//  IncidentSectionViewModel.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 27.05.2025..
//

import Foundation
import UIKit
import SofaAcademic

struct IncidentSection {
    let period: Int
    let incidents: [Incident]
}

final class IncidentSectionViewModel {

    private let sport: SportType
    private let status: EventStatus
    private(set) var sections: [IncidentSection] = []

    init(incidents: [Incident], status: EventStatus, sport: SportType = SportSelectionManager.shared.selectedSport) {
        self.sport = sport
        self.status = status
        self.sections = Self.makeSections(from: incidents)
    }

    private static func makeSections(from incidents: [Incident]) -> [IncidentSection] {
        var result: [IncidentSection] = []
        var currentPeriod = 1
        var currentIncidents: [Incident] = []

        for incident in incidents {
            if incident.type == .periodEnd {
                //result.append(IncidentSection(period: currentPeriod, incidents: currentIncidents))
                currentPeriod += 1
                //currentIncidents = []
            } else {
                currentIncidents.append(incident)
            }
            
           if incident.type == .periodEnd || incident == incidents.last {
                if !currentIncidents.isEmpty {
                    result.append(IncidentSection(period: currentPeriod , incidents: currentIncidents))
                    currentIncidents = []
                }
            }
        }

        if !currentIncidents.isEmpty {
            result.append(IncidentSection(period: currentPeriod, incidents: currentIncidents))
        }
        return result.reversed()
    }

    var titleColor: UIColor {
        switch status {
        case .inProgress:
            return UIColor.red
        default:
            return .primaryBlack
        }
    }
    
    func title(for section: IncidentSection) -> String {
        let score = section.incidents.last?.score ?? ""
        var baseTitle: String

        switch sport {
        case .football:
            if status == .finished && section.period == 2 {
                baseTitle = "FT"
            } else if status == .finished && section.period == 1 {
                    baseTitle = "HT"
            } else {
                switch section.period {
                case 1: baseTitle = "First half"
                case 2: baseTitle = "Second half"
                case 3: baseTitle = "Extra time – First half"
                case 4: baseTitle = "Extra time – Second half"
                case 5: baseTitle = "Penalties"
                default: baseTitle = "Period \(section.period)"
                }
            }

        case .basketball, .americanFootball:
            baseTitle = "\(section.period)Q"
        default:
            baseTitle = "Period \(section.period)"
        }
        let fullTitle = score.isEmpty ? baseTitle : "\(baseTitle) (\(score))"
        return fullTitle
    }
}

