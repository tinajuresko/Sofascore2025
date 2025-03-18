//
//  AppStyles.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit

enum AppStyles {
    
    enum Colors {
        static let primary = UIColor(named: "PrimaryBlackColor") // definirana u assets
        static let secondary = UIColor(named: "SecondaryGrayColor")
        static let dividerColor = UIColor(named: "DividerColor")
        static let appBackgroundColor = UIColor(named: "AppBackgroundColor")
    }
}

extension UIFont {
    static func regular14() -> UIFont? {
        return UIFont(name: "Roboto-Regular", size: 14)
    }
    
    static func regularBold14() -> UIFont? {
        return UIFont(name: "Roboto-Bold", size: 14)
    }
}

