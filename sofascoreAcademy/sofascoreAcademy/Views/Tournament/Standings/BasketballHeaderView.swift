//
//  BasketballHeaderView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.06.2025..
//

import Foundation
import SnapKit
import UIKit

class BasketballHeaderView: UITableViewCell {
    private let indexLabel = UILabel()
    private let teamLabel = UILabel()
    private let matchesLabel = UILabel()
    private let winsLabel = UILabel()
    private let lossesLabel = UILabel()
    private let diffLabel = UILabel()
    private let strLabel = UILabel()
    private let gbLabel = UILabel()
    private let percentageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configure()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        [indexLabel, teamLabel, matchesLabel, winsLabel, lossesLabel, diffLabel, strLabel, gbLabel, percentageLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func styleViews() {
        backgroundColor = .white
        let labels = [indexLabel, teamLabel, matchesLabel, winsLabel, lossesLabel, diffLabel, strLabel, gbLabel, percentageLabel]
        labels.forEach {
            $0.font = .regular14
            $0.textColor = .secondaryGray
        }

        [indexLabel, matchesLabel, winsLabel, lossesLabel, diffLabel, strLabel, gbLabel, percentageLabel].forEach {
            $0.textAlignment = .center
        }
    }
    
    private func setupConstraints() {
        indexLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).inset(16)
            $0.top.bottom.equalTo(contentView).inset(16)
            $0.height.equalTo(16)
            $0.width.equalTo(24)
        }
        
        indexLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(16)
            $0.width.equalTo(24)
        }

        teamLabel.snp.makeConstraints {
            $0.leading.equalTo(indexLabel.snp.trailing).offset(16)
            $0.centerY.equalTo(indexLabel)
            $0.height.equalTo(16)
            $0.width.greaterThanOrEqualTo(104)
        }

        matchesLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLabel.snp.trailing).offset(16)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(16)
        }

        winsLabel.snp.makeConstraints {
            $0.leading.equalTo(matchesLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(16)
        }

        lossesLabel.snp.makeConstraints {
            $0.leading.equalTo(winsLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(16)
        }
        
        diffLabel.snp.makeConstraints {
            $0.leading.equalTo(lossesLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
        
        strLabel.snp.makeConstraints {
            $0.leading.equalTo(diffLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(16)
        }
        
        gbLabel.snp.makeConstraints {
            $0.leading.equalTo(strLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }

        percentageLabel.snp.makeConstraints {
            $0.leading.equalTo(gbLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
        }
    }

    private func configure() {
        indexLabel.text = "#"
        teamLabel.text = "Team"
        matchesLabel.text = "P"
        winsLabel.text = "W"
        lossesLabel.text = "L"
        diffLabel.text = "DIFF"
        strLabel.text = "Str"
        gbLabel.text = "GB"
        percentageLabel.text = "PCT"
    }
}
