//
//  FootballHeaderView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.06.2025..
//

import Foundation
import SnapKit
import UIKit

class FootballHeaderView: UITableViewCell{
    private let indexLabel = UILabel()
    private let teamLabel = UILabel()
    private let matchesLabel = UILabel()
    private let winsLabel = UILabel()
    private let drawsLabel = UILabel()
    private let lossesLabel = UILabel()
    private let goalsLabel = UILabel()
    private let pointsLabel = UILabel()
    
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
        [indexLabel, teamLabel, matchesLabel, winsLabel, drawsLabel, lossesLabel, goalsLabel, pointsLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func styleViews() {
        backgroundColor = .white
        let labels = [indexLabel, teamLabel, matchesLabel, winsLabel, drawsLabel, lossesLabel, goalsLabel, pointsLabel]
        labels.forEach {
            $0.font = .regular14
            $0.textColor = .secondaryGray
        }

        [indexLabel, matchesLabel, winsLabel, drawsLabel, lossesLabel, goalsLabel, pointsLabel].forEach {
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

        drawsLabel.snp.makeConstraints {
            $0.leading.equalTo(winsLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(16)
        }

        lossesLabel.snp.makeConstraints {
            $0.leading.equalTo(drawsLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(24)
            $0.height.equalTo(16)
        }

        goalsLabel.snp.makeConstraints {
            $0.leading.equalTo(lossesLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
        }

        pointsLabel.snp.makeConstraints {
            $0.leading.equalTo(goalsLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(indexLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
    }

    private func configure() {
        indexLabel.text = "#"
        teamLabel.text = "Team"
        matchesLabel.text = "P"
        winsLabel.text = "W"
        drawsLabel.text = "D"
        lossesLabel.text = "L"
        goalsLabel.text = "Goals"
        pointsLabel.text = "PTS"
    }
}
