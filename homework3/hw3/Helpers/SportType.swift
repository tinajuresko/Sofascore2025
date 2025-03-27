//
//  SportType.swift
//  hw3
//
//  Created by Tina Jureško on 27.03.2025..
//

import Foundation
import UIKit

enum SportType {
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
            return UIImage(named: "icon_football")
        case .basketball:
            return UIImage(named: "icon_basketball")
        case .americanFootball:
            return UIImage(named: "icon_american_football")
        }
    }
}
