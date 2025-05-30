//
//  IncidentCell.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 26.05.2025..
//

import Foundation
import UIKit
import SnapKit

class IncidentCell: UITableViewCell {
    let iconImageView = UIImageView()
    let minuteLabel = UILabel()
    let verticalDivider = UIView()
    let playerNameLabel = UILabel()
    let scoreLabel = UILabel()
    let descriptionLabel = UILabel()
    let horizontalDivider = UIView()
    
    var iconLeadingConstraint: Constraint?
    var iconTrailingConstraint: Constraint?
    var dividerLeadingConstraint: Constraint?
    var dividerTrailingConstraint: Constraint?
    var playerLeadingConstraint: Constraint?
    var playerTrailingConstraint: Constraint?
    var scoreLeadingConstraint: Constraint?
    var scoreTrailingConstraint: Constraint?
    
    private var currentConstraintsSet = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        styleViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(minuteLabel)
        contentView.addSubview(verticalDivider)
        contentView.addSubview(horizontalDivider)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(playerNameLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func styleViews() {
        self.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        
        minuteLabel.backgroundColor = .clear
        minuteLabel.textColor = .secondaryGray
        minuteLabel.font = .regularBold12
        
        verticalDivider.backgroundColor = .divider
        horizontalDivider.backgroundColor = .divider
        
        playerNameLabel.backgroundColor = .clear
        playerNameLabel.textColor = .primaryBlack
        playerNameLabel.font = .regular14
        
        scoreLabel.backgroundColor = .clear
        scoreLabel.textColor = .primaryBlack
        scoreLabel.font = .regularBold20
        
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textColor = .secondaryGray
        descriptionLabel.font = .regular12
    }
    
    func activateHomeConstraints() {
        iconLeadingConstraint?.activate()
        iconTrailingConstraint?.deactivate()
        dividerLeadingConstraint?.activate()
        dividerTrailingConstraint?.deactivate()
        playerLeadingConstraint?.activate()
        playerTrailingConstraint?.deactivate()
        scoreLeadingConstraint?.activate()
        scoreTrailingConstraint?.deactivate()
        
        playerNameLabel.textAlignment = .left
        descriptionLabel.textAlignment = .left
        scoreLabel.textAlignment = .left
    }

    func activateAwayConstraints() {
        iconLeadingConstraint?.deactivate()
        iconTrailingConstraint?.activate()
        dividerLeadingConstraint?.deactivate()
        dividerTrailingConstraint?.activate()
        playerLeadingConstraint?.deactivate()
        playerTrailingConstraint?.activate()
        scoreLeadingConstraint?.deactivate()
        scoreTrailingConstraint?.activate()
        
        playerNameLabel.textAlignment = .right
        descriptionLabel.textAlignment = .right
        scoreLabel.textAlignment = .right
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach { $0.snp.removeConstraints() }
        currentConstraintsSet = false
    }

    func configure(with incident: Incident) {
        print(incident)
        let selectedSport = SportSelectionManager.shared.selectedSport
        prepareForReuse()

        if currentConstraintsSet {
            contentView.subviews.forEach { $0.snp.removeConstraints() }
            currentConstraintsSet = false
        }

        iconImageView.image = incident.type.incidentIcon
        minuteLabel.text = String(incident.minute) + "'"
        playerNameLabel.text = incident.player
        descriptionLabel.text = incident.description
        
        scoreLabel.isHidden = (incident.type != .goal)
        if incident.type == .goal {
            scoreLabel.text = incident.score
        }

        if !currentConstraintsSet {
            let layout: IncidentCellLayout
            switch selectedSport {
            case .football, .americanFootball:
                horizontalDivider.isHidden = true
                layout = FootballIncidentLayout()
            case .basketball:
                horizontalDivider.isHidden = false
                layout = BasketballIncidentLayout()
            }

            layout.setupConstraints(to: self)
            currentConstraintsSet = true
        }

        if incident.isHomeTeam ?? true {
            activateHomeConstraints()
        } else {
            activateAwayConstraints()
        }
    }
}
