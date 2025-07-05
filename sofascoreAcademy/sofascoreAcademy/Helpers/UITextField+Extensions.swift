//
//  UITextField+Extensions.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 18.06.2025..
//

import Foundation
import UIKit

final class PaddedTextField: UITextField {

    private let padding: CGFloat = 12
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: adjustedInsets())
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: adjustedInsets())
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: adjustedInsets())
    }

    // MARK: - RTL-aware padding

    private func adjustedInsets() -> UIEdgeInsets {
        if effectiveUserInterfaceLayoutDirection == .rightToLeft {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding)
        } else {
            return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0)
        }
    }

    // MARK: - Styling

    private func setup() {
        borderStyle = .none
        backgroundColor = .clear
        layer.cornerRadius = 8
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryGray.cgColor
        font = .regular14
        textColor = .secondaryGray
        autocapitalizationType = .none
        semanticContentAttribute = .unspecified
    }
   
    func setPlaceholder(_ text: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color]
        )
    }
}
