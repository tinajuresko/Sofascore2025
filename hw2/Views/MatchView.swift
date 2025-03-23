//
//  MatchView.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MatchView: BaseView {
    
    private let timeLabel = UILabel()
    private let timeStatusLabel = UILabel()
    private let dividerView = UIView()
    private let homeTeamLogoImageView = UIImageView()
    private let awayTeamLogoImageView = UIImageView()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    override func addViews() {
        super.addViews()
        addSubview(timeLabel)
        addSubview(timeStatusLabel)
        
        addSubview(dividerView)
        
        addSubview(homeTeamLogoImageView)
        addSubview(homeTeamLabel)
        addSubview(homeScoreLabel)
        
        addSubview(awayTeamLogoImageView)
        addSubview(awayTeamLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        timeLabel.setStyle(.regular14)
        timeLabel.textColor = AppStyles.Colors.secondary
        timeStatusLabel.setStyle(.regular14)
        timeLabel.textAlignment = .center
        timeStatusLabel.textAlignment = .center
        
        dividerView.backgroundColor = AppStyles.Colors.dividerColor
        
        homeTeamLogoImageView.contentMode = .scaleAspectFit
        awayTeamLogoImageView.contentMode = .scaleAspectFit
        
        homeTeamLabel.setStyle(.regular14)
        homeTeamLabel.textColor = AppStyles.Colors.secondary
        homeTeamLabel.numberOfLines = 0
        homeTeamLabel.lineBreakMode = .byWordWrapping
        
        awayTeamLabel.setStyle(.regular14)
        awayTeamLabel.textColor = AppStyles.Colors.primary
        awayTeamLabel.numberOfLines = 0
        awayTeamLabel.lineBreakMode = .byWordWrapping
        
        homeScoreLabel.setStyle(.regular14)
        homeScoreLabel.textAlignment = .right

        awayScoreLabel.setStyle(.regular14) 
        awayScoreLabel.textAlignment = .right
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
                
        timeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(56)
            $0.height.equalTo(16)
        }
            
        timeStatusLabel.snp.makeConstraints {
            $0.centerX.equalTo(timeLabel)
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.height.equalTo(16)
            $0.leading.equalToSuperview().inset(16)
        }
            
        dividerView.snp.makeConstraints {
            $0.leading.equalTo(timeLabel.snp.trailing).offset(16)
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(8)
        }
            
        homeTeamLogoImageView.snp.makeConstraints {
            $0.leading.equalTo(dividerView.snp.trailing).offset(16)
            $0.size.equalTo(16)
            $0.top.equalToSuperview().offset(10)
        }
            
        homeTeamLabel.snp.makeConstraints {
            $0.centerY.equalTo(homeTeamLogoImageView)
            $0.leading.equalTo(homeTeamLogoImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(homeScoreLabel.snp.leading).offset(-8)
            $0.height.equalTo(16)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.centerY.equalTo(homeTeamLogoImageView)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.greaterThanOrEqualTo(homeTeamLogoImageView.snp.trailing).offset(8)
            $0.height.equalTo(16)
        }
        homeScoreLabel.adjustsFontSizeToFitWidth = true
        homeScoreLabel.minimumScaleFactor = 0.5
        
        awayTeamLogoImageView.snp.makeConstraints {
            $0.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(4)
            $0.leading.equalTo(dividerView.snp.trailing).offset(16)
            $0.size.equalTo(16)
        }
                
        awayTeamLabel.snp.makeConstraints {
            $0.centerY.equalTo(awayTeamLogoImageView)
            $0.leading.equalTo(awayTeamLogoImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(awayScoreLabel.snp.leading).offset(-8)
            $0.height.equalTo(16)
        }
                
        awayScoreLabel.snp.makeConstraints {
            $0.centerY.equalTo(awayTeamLogoImageView)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.greaterThanOrEqualTo(awayTeamLogoImageView.snp.trailing).offset(8)
            $0.height.equalTo(16)
        }
        awayScoreLabel.adjustsFontSizeToFitWidth = true
        awayScoreLabel.minimumScaleFactor = 0.5
    }
        
    func configure(with viewModel: MatchViewModel) {
        let viewModel = viewModel
        
        timeLabel.text = viewModel.time
        timeStatusLabel.text = viewModel.timeStatusText
        timeStatusLabel.textColor = viewModel.timeStatusColor
        
        homeTeamLogoImageView.image = viewModel.homeTeamLogo
        
        homeTeamLabel.text = viewModel.homeTeamName
        homeScoreLabel.text = viewModel.homeScore
        homeScoreLabel.textColor = viewModel.homeScoreColor
        
        awayTeamLogoImageView.image = viewModel.awayTeamLogo
            
        awayTeamLabel.text = viewModel.awayTeamName
        awayScoreLabel.text = viewModel.awayScore
        awayScoreLabel.textColor = viewModel.awayScoreColor
        
    }
}
