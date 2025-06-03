//
//  StandingsCellType.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.06.2025..
//

import Foundation
import UIKit

enum StandingsCellType {
    case football
    case basketball
    case americanFootball
    
    var reuseIdentifier: String {
        switch self {
        case .football: return "FootballStandingsCell"
        case .basketball: return "BasketballStandingsCell"
        case .americanFootball: return "AmFootballStandingsCell"
        }
    }
    
    var cellClass: AnyClass {
        switch self {
        case .football: return FootballStandingsCell.self
        case .basketball: return BasketballStandingsCell.self
        case .americanFootball: return AmFootballStandingsCell.self
        }
    }
    
    static func from(sport: SportType) -> StandingsCellType {
        switch sport {
        case .football: return .football
        case .basketball: return .basketball
        case .americanFootball: return .americanFootball
        }
    }
    
    func registerCell(on tableView: UITableView) {
        tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
}
