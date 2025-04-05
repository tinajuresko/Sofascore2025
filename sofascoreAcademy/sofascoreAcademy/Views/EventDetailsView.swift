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

class EventDetailsView: BaseView {
    
    private let homeTeamLogoImageView = AsyncImageView()
    private let awayTeamLogoImageView = AsyncImageView()
    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let eventDetailLabel = UILabel()
    private let eventStatusLabel = UILabel()
    private let viewTournamentsButton = UIButton()
    private let resultsView = UIView()
    private let resultsLabel = UILabel()
    
    private let homeTeamStackView = UIStackView()
    private let awayTeamStackView = UIStackView()
    private let teamsStackView = UIStackView()
    private let statusStackView = UIStackView()
    
    override func addViews() {
        super.addViews()
        configureTeamStackViews()
        configureTeamStackView()
        configureStatusStackView()
        addSubview(teamsStackView)
        resultsView.addSubview(resultsLabel)
        addSubview(resultsView)
        addSubview(viewTournamentsButton)
    }

    func configureTeamStackViews() {
        homeTeamStackView.addArrangedSubview(homeTeamLogoImageView)
        homeTeamStackView.addArrangedSubview(homeTeamLabel)
                
        awayTeamStackView.addArrangedSubview(awayTeamLogoImageView)
        awayTeamStackView.addArrangedSubview(awayTeamLabel)
    }
    
    func configureStatusStackView() {
        statusStackView.addArrangedSubview(eventDetailLabel)
        statusStackView.addArrangedSubview(eventStatusLabel)
    }
    
    func configureTeamStackView() {
        teamsStackView.addArrangedSubview(homeTeamStackView)
        teamsStackView.addArrangedSubview(statusStackView)
        teamsStackView.addArrangedSubview(awayTeamStackView)
    }
    
    override func styleViews() {
        homeTeamStackView.axis = .vertical
        homeTeamStackView.alignment = .center
        homeTeamStackView.spacing = 8
        homeTeamStackView.backgroundColor = .clear
                
        awayTeamStackView.axis = .vertical
        awayTeamStackView.alignment = .center
        awayTeamStackView.spacing = 8
        awayTeamStackView.backgroundColor = .clear
        
        teamsStackView.axis = .horizontal
        teamsStackView.alignment = .center
        teamsStackView.distribution = .fillEqually
        teamsStackView.backgroundColor = .clear
        
        statusStackView.axis = .vertical
        statusStackView.alignment = .center
        statusStackView.spacing = 8
        statusStackView.backgroundColor = .clear
        
        homeTeamLabel.font = .regularBold14
        awayTeamLabel.font = .regularBold14
        homeTeamLabel.textColor = .primaryBlack
        awayTeamLabel.textColor = .primaryBlack
        
        eventDetailLabel.textAlignment = .center
        eventStatusLabel.font = .regular14
        eventStatusLabel.textAlignment = .center
        
        resultsView.backgroundColor = .containerBackground
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
       
        teamsStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        homeTeamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
                
        awayTeamLogoImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        resultsView.snp.makeConstraints {
            $0.top.equalTo(teamsStackView.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.height.equalTo(52)
        }
        
        resultsLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
      
        viewTournamentsButton.snp.makeConstraints {
            $0.top.equalTo(resultsView.snp.bottom).offset(8)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.height.equalTo(40)
        }
        awayTeamLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        homeTeamLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        eventDetailLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        eventStatusLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        resultsLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(with event: MatchViewModel) {
        homeTeamLogoImageView.setImage(from: event.homeTeamLogo)
        homeTeamLabel.text = event.homeTeamName
        awayTeamLogoImageView.setImage(from: event.awayTeamLogo)
        awayTeamLabel.text = event.awayTeamName
        if let eventDate = event.eventDetailsText {
            eventDetailLabel.text = eventDate
            eventDetailLabel.font = .regular14
            eventDetailLabel.textColor = .primaryBlack
            eventStatusLabel.text = event.time
        } else {
            eventDetailLabel.attributedText = event.scoresText
            eventDetailLabel.font = .regularBold14
            eventStatusLabel.text = event.eventDetailsStatusText
        }
        eventStatusLabel.textColor = event.eventDetailsStatusColor
    }
}
