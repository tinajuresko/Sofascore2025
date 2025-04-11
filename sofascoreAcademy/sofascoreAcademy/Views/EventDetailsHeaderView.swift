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
    private let viewTournamentsButton = UIButton()
    private let resultsView = UIView()
    private let resultsLabel = UILabel()
        
    override func addViews() {
        super.addViews()
            
        addSubview(homeTeamLogoImageView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamLogoImageView)
        addSubview(awayTeamLabel)
        addSubview(eventDetailLabel)
        addSubview(eventStatusLabel)
        addSubview(resultsView)
        resultsView.addSubview(resultsLabel)
        addSubview(viewTournamentsButton)
    }
        
    override func styleViews() {
        homeTeamLabel.font = .regularBold14
        awayTeamLabel.font = .regularBold14
        homeTeamLabel.textColor = .primaryBlack
        awayTeamLabel.textColor = .primaryBlack
        homeTeamLabel.textAlignment = .center
        awayTeamLabel.textAlignment = .center
        homeTeamLabel.numberOfLines = 2
        homeTeamLabel.lineBreakMode = .byTruncatingTail
        awayTeamLabel.numberOfLines = 2
        awayTeamLabel.lineBreakMode = .byTruncatingTail
            
        eventDetailLabel.font = .regular14
        eventDetailLabel.textAlignment = .center
        eventDetailLabel.numberOfLines = 2
        eventDetailLabel.lineBreakMode = .byTruncatingTail
            
        eventStatusLabel.font = .regular14
        eventStatusLabel.textAlignment = .center
        eventStatusLabel.numberOfLines = 2
        eventStatusLabel.lineBreakMode = .byTruncatingTail
            
        resultsView.backgroundColor = .containerBackground
        resultsView.layer.cornerRadius = 6
            
        resultsLabel.text = "No result yet."
        resultsLabel.font = .regular14
        resultsLabel.textColor = .secondaryGray
        resultsLabel.textAlignment = .center
            
        viewTournamentsButton.setTitle("View tournaments", for: .normal)
        viewTournamentsButton.titleLabel?.font = .regularBold14
        viewTournamentsButton.setTitleColor(.headerBackground, for: .normal)
        viewTournamentsButton.layer.borderColor = UIColor.headerBackground.cgColor
        viewTournamentsButton.layer.borderWidth = 2
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
        }
            
        eventStatusLabel.snp.makeConstraints {
            $0.top.equalTo(eventDetailLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(136)
        }
            
        resultsView.snp.makeConstraints {
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(layoutMargins.left)
            $0.trailing.equalToSuperview().offset(-layoutMargins.right)
            $0.height.equalTo(52)
        }
            
        resultsLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
            
        viewTournamentsButton.snp.makeConstraints {
            $0.top.equalTo(resultsView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(layoutMargins.left).offset(74)
            $0.trailing.equalToSuperview().offset(-layoutMargins.right).offset(-74)
            $0.height.equalTo(40)
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
