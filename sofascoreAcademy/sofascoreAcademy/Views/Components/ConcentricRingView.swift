//
//  ConcentricRingView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.06.2025..
//

import Foundation
import UIKit

class ConcentricRingView: UIView {
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    var progress: CGFloat = 0.0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let circlePath = UIBezierPath(arcCenter: center, radius: 20, startAngle: -.pi/2, endAngle: 1.5 * .pi, clockwise: true)

        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.periodContainerBackground.cgColor
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)

        progressLayer.path = circlePath.cgPath
        progressLayer.strokeColor = UIColor.headerBackground.cgColor
        progressLayer.lineWidth = 6
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius: CGFloat = min(bounds.width, bounds.height) / 2 - 6

        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: -.pi / 2, endAngle: 1.5 * .pi, clockwise: true)

        trackLayer.path = circlePath.cgPath
        progressLayer.path = circlePath.cgPath
    }
}
