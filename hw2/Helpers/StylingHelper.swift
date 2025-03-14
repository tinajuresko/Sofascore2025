//
//  StylingHelper.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit

class StylingHelper {
    
    static func styleImageView(imageView: UIImageView, imageName: String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = contentMode
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func styleLabel(label: UILabel, font: UIFont, color: UIColor, textAlignment: NSTextAlignment = .natural, numberOfLines: Int = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) {
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.textAlignment = textAlignment
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}


