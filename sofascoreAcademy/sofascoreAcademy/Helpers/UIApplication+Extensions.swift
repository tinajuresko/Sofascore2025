//
//  UIApplication+Extensions.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 18.04.2025..
//

import Foundation
import UIKit

extension UIApplication {
    static var rootVC: RootViewController? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first?.rootViewController as? RootViewController
    }
}
