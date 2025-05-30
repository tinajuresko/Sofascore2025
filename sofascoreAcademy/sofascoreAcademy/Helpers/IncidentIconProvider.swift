//
//  IncidentIconProvider.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 29.05.2025..
//

import Foundation
import UIKit

struct IncidentIconProvider {
    static func icon(for type: IncidentType, sport: SportType) -> UIImage? {
        if let specificIcon = perSportIcons[type]?[sport] {
            return UIImage(named: specificIcon)
        }
        return .redCard
    }

    private static let perSportIcons: [IncidentType: [SportType: String]] = [
        .goal: [
            .football: "goal",
            .basketball: "basketball_score",
            .americanFootball: "americanfootball_touchdown"
        ]
    ]
}
