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
    private let navigationIconImageView = UIImageView()
    var onBackTapped: (() -> Void)?
    
    override func addViews() {
        super.addViews()
        addSubview(navigationIconImageView)
        addSubview(leagueLogoImageView)
        addSubview(titleLabel)
    }

    override func styleViews() {
        self.backgroundColor = .clear
        titleLabel.font = .regular14
        titleLabel.textColor = .secondaryGray
        navigationIconImageView.image = .navigationIcon
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        navigationIconImageView.isUserInteractionEnabled = true
        navigationIconImageView.addGestureRecognizer(tapGesture)
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        navigationIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
       
        leagueLogoImageView.snp.makeConstraints {
            $0.leading.equalTo(navigationIconImageView.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueLogoImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func configure(with league: League, selectedSport: SportType) {
        
        leagueLogoImageView.setImage(from: league.logoUrl)
        if let country = league.country?.name {
            titleLabel.text = selectedSport.title + ", " + country + ", " + league.name
        } else {
            titleLabel.text = selectedSport.title + ", " + league.name
        }
    }
    
    @objc private func backTapped() {
        onBackTapped?()
    }
}
