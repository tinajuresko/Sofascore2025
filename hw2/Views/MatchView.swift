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
    private let dividerImageView = UIImageView()
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
        
        addSubview(dividerImageView)
        
        addSubview(homeTeamLogoImageView)
        addSubview(homeTeamLabel)
        addSubview(homeScoreLabel)
        
        addSubview(awayTeamLogoImageView)
        addSubview(awayTeamLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        super.styleViews()
        
        StylingHelper.styleImageView(imageView: dividerImageView, imageName: "DividerHorizontal")
        if let regularFont = AppStyles.Fonts.regular(size: 14) {
            StylingHelper.styleLabel(label: timeLabel, font: regularFont, color: AppStyles.Colors.secondary ?? .gray, textAlignment: .center)
            StylingHelper.styleLabel(label: homeTeamLabel, font: regularFont, color: AppStyles.Colors.secondary ?? .gray)
            StylingHelper.styleLabel(label: awayTeamLabel, font: regularFont, color: AppStyles.Colors.primary ?? .black, textAlignment: .left)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
                
            timeLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(4)
                make.top.equalToSuperview().offset(10)
                make.centerY.equalTo(dividerImageView).offset(-10)
                make.width.equalTo(56)
                make.height.equalTo(16)
            }
            
            timeStatusLabel.snp.makeConstraints { make in
                make.centerX.equalTo(timeLabel)
                make.top.equalTo(timeLabel.snp.bottom).offset(4)
                make.width.equalTo(56)
                make.height.equalTo(16)
            }
            
            dividerImageView.snp.makeConstraints { make in
                make.centerY.equalTo(homeTeamLogoImageView).offset(10)
                make.left.equalToSuperview().offset(64)
                make.width.equalTo(1)
                make.height.equalTo(40)
            }
            
            homeTeamLogoImageView.snp.makeConstraints { make in
                make.left.equalTo(dividerImageView.snp.right).offset(16)
                make.width.height.equalTo(16)
            }
            
            homeTeamLabel.snp.makeConstraints { make in
                make.centerY.equalTo(homeTeamLogoImageView)
                make.left.equalTo(homeTeamLogoImageView.snp.right).offset(8)
                make.width.equalTo(192)
                make.height.equalTo(16)
                
            }
            
            homeScoreLabel.snp.makeConstraints { make in
                make.centerY.equalTo(homeTeamLogoImageView)
                make.left.equalTo(homeTeamLabel.snp.right).offset(16)
                make.width.equalTo(32)
                make.height.equalTo(16)
            }
            
            awayTeamLogoImageView.snp.makeConstraints { make in
                make.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(4)
                make.left.equalTo(dividerImageView.snp.right).offset(16)
                make.width.height.equalTo(16)
            }
                
            awayTeamLabel.snp.makeConstraints { make in
                make.centerY.equalTo(awayTeamLogoImageView)
                make.left.equalTo(awayTeamLogoImageView.snp.right).offset(8)
                make.width.equalTo(192)
                make.height.equalTo(16)
                
            }
                
            awayScoreLabel.snp.makeConstraints { make in
                make.centerY.equalTo(awayTeamLogoImageView)
                make.left.equalTo(homeTeamLabel.snp.right).offset(16)
                make.width.equalTo(32)
                make.height.equalTo(16)
            }
        }
        
    func configure(viewModel: MatchViewModel?) {
        guard let viewModel = viewModel else { return }
        
        timeLabel.text = viewModel.time
        timeStatusLabel.text = viewModel.timeStatusText
        
        homeTeamLabel.text = viewModel.homeTeamName
        homeScoreLabel.text = viewModel.homeScore
            
        awayTeamLabel.text = viewModel.awayTeamName
        awayScoreLabel.text = viewModel.awayScore
        
        if let regularFont = AppStyles.Fonts.regular(size: 14) {
            StylingHelper.styleLabel(label: timeStatusLabel, font: regularFont, color: viewModel.timeStatusColor, textAlignment: .center)
            StylingHelper.styleLabel(label: homeScoreLabel, font: regularFont, color: viewModel.homeScoreColor, textAlignment: .right)
            StylingHelper.styleLabel(label: awayScoreLabel, font: regularFont, color: viewModel.awayScoreColor, textAlignment: .right)
        }
        
        StylingHelper.styleImageView(imageView: homeTeamLogoImageView, imageName: viewModel.homeTeamName)
        StylingHelper.styleImageView(imageView: awayTeamLogoImageView, imageName: viewModel.awayTeamName)
    }
}
