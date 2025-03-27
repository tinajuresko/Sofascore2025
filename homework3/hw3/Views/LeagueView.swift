//
//  LeagueView.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LeagueView: BaseView {
    
    private let countryLabel = UILabel()
    private let nameLabel = UILabel()
    private let logoImageView = UIImageView()
    private let arrowImageView = UIImageView()
        
    override func addViews() {
        super.addViews()
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(arrowImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        arrowImageView.image = UIImage(named: "Vector")
        logoImageView.contentMode = .scaleAspectFit
        arrowImageView.contentMode = .scaleAspectFit
        
        countryLabel.font = .regularBold14
        countryLabel.textColor = .primaryBlack
        countryLabel.numberOfLines = 2
        countryLabel.lineBreakMode = .byWordWrapping
        
        nameLabel.font = .regularBold14
        nameLabel.textColor = .secondaryGray
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byWordWrapping
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(32)
        }
        
        countryLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-10)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(countryLabel)
            $0.leading.equalTo(countryLabel.snp.trailing).offset(10)
            $0.size.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(arrowImageView)
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    func setLogoImageView(_ imageName: String) {
        logoImageView.image = UIImage(named: imageName)
    }
    
    func setCountryLabel(_ text: String) {
        countryLabel.text = text
    }
    
    func setNameLabel(_ name: String) {
        nameLabel.text = name
    }
}
