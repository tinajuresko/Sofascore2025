//
//  SportCellView.swift
//  hw3
//
//  Created by Tina Jureško on 19.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class SportCellView: BaseView {
    private let sportIconImageView: UIImageView = UIImageView()
    private let sportNameLabel: UILabel = UILabel()
    
    override func addViews() {
        addSubview(sportIconImageView)
        addSubview(sportNameLabel)
    }
    
    override func styleViews() {
        sportNameLabel.textAlignment = .center
        sportNameLabel.setStyle(.regular14)
        sportNameLabel.textColor = .white
        sportIconImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        sportIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        sportNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sportIconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(with sport: SportType) {
        sportIconImageView.image = sport.icon
        sportNameLabel.text = sport.title
    }
}
