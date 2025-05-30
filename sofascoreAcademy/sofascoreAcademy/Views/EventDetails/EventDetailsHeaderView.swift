//
//  EventDetailsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.04.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class EventDetailsHeaderView: BaseView {
    
    private let homeTeamLogoImageView = AsyncImageView()
    private let awayTeamLogoImageView = AsyncImageView()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let eventDetailLabel = UILabel()
    private let eventStatusLabel = UILabel()
        
    override func addViews() {
        super.addViews()
            
        addSubview(homeTeamLogoImageView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLogoImageView)
        addSubview(awayTeamLabel)
        addSubview(eventDetailLabel)
        addSubview(eventStatusLabel)
    }
        
    override func styleViews() {
        homeTeamLabel.font = .regularBold14
        awayTeamLabel.font = .regularBold14
        homeTeamLabel.textColor = .primaryBlack
        awayTeamLabel.textColor = .primaryBlack
        homeTeamLabel.textAlignment = .center
        awayTeamLabel.textAlignment = .center
        homeTeamLabel.numberOfLines = 2
        awayTeamLabel.numberOfLines = 2
            
        eventDetailLabel.font = .regular14
        eventDetailLabel.textAlignment = .center
        eventDetailLabel.numberOfLines = 2
            
        eventStatusLabel.font = .regular14
        eventStatusLabel.textAlignment = .center
        eventStatusLabel.numberOfLines = 2
    }
        
    override func setupConstraints() {
        super.setupConstraints()
            
        homeTeamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(40)
        }
            
        homeTeamLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamLogoImageView.snp.bottom).offset(8)
            $0.centerX.equalTo(homeTeamLogoImageView)
            $0.width.equalTo(96)
        }
            
        awayTeamLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-24)
            $0.size.equalTo(40)
        }
            
        awayTeamLabel.snp.makeConstraints {
            $0.top.equalTo(awayTeamLogoImageView.snp.bottom).offset(8)
            $0.centerX.equalTo(awayTeamLogoImageView)
            $0.width.equalTo(96)
        }
            
        eventDetailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(136)
            $0.height.equalTo(40)
        }
            
        eventStatusLabel.snp.makeConstraints {
            $0.top.equalTo(eventDetailLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(136)
            $0.height.equalTo(16)
        }
    }
        
    func configure(with selectedEvent: EventDetailsViewModel) {
        homeTeamLogoImageView.setImage(from: selectedEvent.homeTeamLogo)
        homeTeamLabel.text = selectedEvent.homeTeamName
        awayTeamLogoImageView.setImage(from: selectedEvent.awayTeamLogo)
        awayTeamLabel.text = selectedEvent.awayTeamName
            
        if let eventDate = selectedEvent.eventDetailsText {
            eventDetailLabel.text = eventDate
            eventDetailLabel.font = .regular14
            eventDetailLabel.textColor = .primaryBlack
            eventStatusLabel.text = selectedEvent.time
        } else {
            eventDetailLabel.attributedText = selectedEvent.scoresText
            eventDetailLabel.font = .headlineBold32
            eventStatusLabel.text = selectedEvent.eventDetailsStatusText
        }
        eventStatusLabel.textColor = selectedEvent.eventDetailsStatusColor
    }
}
