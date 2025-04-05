//
//  CustomNavigationTitleView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.04.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class CustomNavigationTitleView: BaseView {
    private let leagueLogoImageView = AsyncImageView()
    private let titleLabel = UILabel()
    
    override func addViews() {
        super.addViews()
        addSubview(leagueLogoImageView)
        addSubview(titleLabel)
    }

    override func styleViews() {
        leagueLogoImageView.contentMode = .scaleAspectFit
        titleLabel.font = .regular14
        titleLabel.textColor = .secondaryGray
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        snp.makeConstraints {
            $0.height.equalTo(16)
        }
       
        leagueLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(with league: League, selectedSport: SportType) {
        if let logoURL = league.logoUrl {
            leagueLogoImageView.setImage(from: logoURL)
        }
        if let country = league.country?.name {
            titleLabel.text = selectedSport.title + ", " + country + ", " + league.name
        } else {
            titleLabel.text = selectedSport.title + ", " + league.name
        }
    }
}
