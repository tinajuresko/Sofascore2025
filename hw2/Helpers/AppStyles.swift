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
    }
    
    enum Fonts {
        static func regular(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Regular", size: size)
        }
        
        static func bold(size: CGFloat) -> UIFont? {
            return UIFont(name: "Roboto-Bold", size: size)
        }
    }
}

