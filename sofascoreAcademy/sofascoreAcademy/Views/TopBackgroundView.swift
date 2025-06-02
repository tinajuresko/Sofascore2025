//
//  TopBackgroundView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TopBackgroundView: BaseView {
    private let backgroundView = UIView()
    
    override func addViews() {
        addSubview(backgroundView)
    }
    
    override func styleViews() {
        backgroundView.backgroundColor = .headerBackground
    }
    
    override func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
