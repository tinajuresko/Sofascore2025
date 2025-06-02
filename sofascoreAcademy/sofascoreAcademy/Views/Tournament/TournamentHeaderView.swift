//
//  TournamentHeaderView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TournamentHeaderView: BaseView {
    private let leagueLabel = UILabel()
    private let countryLabel = UILabel()
    private let leagueImageContainerView = UIView()
    private let leagueImageView = AsyncImageView()
    
    override func addViews() {
        super.addViews()
        addSubview(leagueImageContainerView)
        leagueImageContainerView.addSubview(leagueImageView)
        addSubview(countryLabel)
        addSubview(leagueLabel)
    }

    override func styleViews() {
        self.backgroundColor = .headerBackground
        
        leagueImageContainerView.backgroundColor = .white
        leagueImageContainerView.layer.cornerRadius = 8
        leagueImageContainerView.clipsToBounds = true

        leagueImageView.contentMode = .scaleAspectFit

        countryLabel.font = .regularBold14
        countryLabel.textColor = .white
        countryLabel.textAlignment = .left

        leagueLabel.font = .regularBold20
        leagueLabel.textColor = .white
        leagueLabel.textAlignment = .left
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        leagueImageContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(56)
        }

        leagueImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        leagueLabel.snp.makeConstraints {
            $0.top.equalTo(leagueImageContainerView)
            $0.leading.equalTo(leagueImageContainerView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        countryLabel.snp.makeConstraints {
            $0.top.equalTo(leagueLabel.snp.bottom).offset(4)
            $0.leading.equalTo(leagueLabel)
            $0.trailing.equalTo(leagueLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    func configure(leagueName: String, countryName: String, leagueImageUrl: String) {
        leagueLabel.text = leagueName
        countryLabel.text = countryName
        leagueImageView.setImage(from: leagueImageUrl)
    }
}
