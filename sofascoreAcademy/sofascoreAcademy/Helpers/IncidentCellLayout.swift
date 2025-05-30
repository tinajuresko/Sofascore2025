//
//  IncidentCellLayout.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 28.05.2025..
//

import Foundation
import UIKit

protocol IncidentCellLayout {
    func setupConstraints(to cell: IncidentCell)
}

class FootballIncidentLayout: IncidentCellLayout {
    func setupConstraints(to cell: IncidentCell) {
        cell.iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(24)
            cell.iconLeadingConstraint = $0.leading.equalToSuperview().offset(16).constraint
            cell.iconTrailingConstraint = $0.trailing.equalToSuperview().inset(16).constraint
            $0.size.equalTo(24)
        }
        
        cell.minuteLabel.snp.makeConstraints {
            $0.top.equalTo(cell.iconImageView.snp.bottom)
            $0.centerX.equalTo(cell.iconImageView)
            $0.height.equalTo(16)
            $0.width.lessThanOrEqualTo(40)
        }
        
        cell.verticalDivider.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(8)
            cell.dividerLeadingConstraint = $0.leading.equalTo(cell.iconImageView.snp.trailing).offset(15).constraint
            cell.dividerTrailingConstraint = $0.trailing.equalTo(cell.iconImageView.snp.leading).offset(-15).constraint
        }
        
        cell.scoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerY.equalTo(cell.playerNameLabel)
            cell.scoreLeadingConstraint = $0.leading.equalTo(cell.verticalDivider.snp.trailing).offset(12).constraint
            cell.scoreTrailingConstraint = $0.trailing.equalTo(cell.verticalDivider.snp.leading).offset(-12).constraint
            $0.width.lessThanOrEqualTo(84)
        }
        
        cell.scoreLabel.setContentHuggingPriority(.required, for: .horizontal)
        cell.scoreLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        cell.playerNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            cell.playerLeadingConstraint = $0.leading.equalTo(cell.scoreLabel.snp.trailing).offset(12).constraint
            cell.playerTrailingConstraint = $0.trailing.equalTo(cell.scoreLabel.snp.leading).offset(-12).constraint
        }
        
        cell.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(cell.playerNameLabel.snp.bottom)
            $0.leading.greaterThanOrEqualToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.leading.equalTo(cell.playerNameLabel.snp.leading)
            $0.trailing.equalTo(cell.playerNameLabel.snp.trailing)
            $0.height.equalTo(16)
        }
    }
}

class BasketballIncidentLayout: IncidentCellLayout {
    
    func setupConstraints(to cell: IncidentCell) {
        cell.iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(24)
            cell.iconLeadingConstraint = $0.leading.equalToSuperview().offset(16).constraint
            cell.iconTrailingConstraint = $0.trailing.equalToSuperview().inset(16).constraint
            $0.size.equalTo(24)
        }

        cell.verticalDivider.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(24)
            $0.top.equalToSuperview().inset(8)
            cell.dividerLeadingConstraint = $0.leading.equalTo(cell.iconImageView.snp.trailing).offset(15).constraint
            cell.dividerTrailingConstraint = $0.trailing.equalTo(cell.iconImageView.snp.leading).offset(-15).constraint
        }
        
        cell.scoreLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerY.equalTo(cell.verticalDivider)
            cell.scoreLeadingConstraint = $0.leading.equalTo(cell.verticalDivider.snp.trailing).offset(12).constraint
            cell.scoreTrailingConstraint = $0.trailing.equalTo(cell.verticalDivider.snp.leading).offset(-12).constraint
            $0.width.lessThanOrEqualTo(84)
        }
        
        cell.minuteLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.centerY.equalTo(cell.iconImageView)
            $0.width.lessThanOrEqualTo(24)
        }
        
        cell.horizontalDivider.snp.makeConstraints {
            $0.top.equalTo(cell.minuteLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(cell.minuteLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(1)
        }
    }
}
