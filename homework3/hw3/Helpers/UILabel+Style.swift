//
//  UILabel+Style.swift
//  hw3
//
//  Created by Tina Jureško on 21.03.2025..
//

import Foundation
import UIKit

struct LabelStyle {
    public let font: UIFont
    public let lineHeight: CGFloat?

    public init(font: UIFont, lineHeight: CGFloat? = nil) {
        self.font = font
        self.lineHeight = lineHeight
    }
}

extension UILabel {
    func setStyle(_ style: LabelStyle?) {
        guard let style = style else { return }
        
        self.font = style.font
        
        if let lineHeight = style.lineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight - self.font.lineHeight
        }
    }
}

extension LabelStyle {
    static let regular14 = LabelStyle(font: UIFont.regular14, lineHeight: 16)
    static let regularBold14 = LabelStyle(font: UIFont.regularBold14, lineHeight: 16)
}
