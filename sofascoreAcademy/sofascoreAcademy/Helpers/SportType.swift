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
            return .iconFootball
        case .basketball:
            return .iconBasketball
        case .americanFootball:
            return .iconAmericanFootball
        }
    }
    
    var urlSlug: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "am-football"
        }
    }
}
