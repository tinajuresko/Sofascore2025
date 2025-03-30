//
//  SportType.swift
//  hw3
//
//  Created by Tina Jureško on 27.03.2025..
//

import Foundation
import UIKit

enum SportType: CaseIterable {
    case football
    case basketball
    case americanFootball
    
    var title: String {
        switch self {
        case .football:
            return "Football"
        case .basketball:
            return "Basketball"
        case .americanFootball:
            return "American Football"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .football:
            return .icon_football
        case .basketball:
            return .icon_basketball
        case .americanFootball:
            return .icon_american_football
        }
    }
}
