//
//  AmFootballStandingsCell.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.06.2025..
//

import Foundation
import UIKit
import SnapKit

class AmFootballStandingsCell: UITableViewCell {
    private let indexContainer = UIView()
    private let indexLabel = UILabel()
    private let teamLabel = UILabel()
    private let matchesLabel = UILabel()
    private let winsLabel = UILabel()
    private let drawsLabel = UILabel()
    private let lossesLabel = UILabel()
    private let percentageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        contentView.addSubview(indexContainer)
        indexContainer.addSubview(indexLabel)
        
        [teamLabel, matchesLabel, winsLabel, drawsLabel, lossesLabel, percentageLabel].forEach {
            contentView.addSubview($0)
        }
    }

    private func styleViews() {
        backgroundColor = .white
        
        indexContainer.backgroundColor = .periodContainerBackground
        indexContainer.layer.cornerRadius = 12
        indexContainer.clipsToBounds = true
        
        let labels = [indexLabel, teamLabel, matchesLabel, winsLabel, drawsLabel, lossesLabel, percentageLabel]
        labels.forEach {
            $0.font = .regular14
            $0.textColor = .primaryBlack
        }

        [indexLabel, matchesLabel, winsLabel, drawsLabel, lossesLabel, percentageLabel].forEach {
            $0.textAlignment = .center
        }
    }

    private func setupConstraints() {
        
        indexContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }

        indexLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        teamLabel.snp.makeConstraints {
            $0.leading.equalTo(indexContainer.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(104)
        }

        matchesLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLabel.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        winsLabel.snp.makeConstraints {
            $0.leading.equalTo(matchesLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        drawsLabel.snp.makeConstraints {
            $0.leading.equalTo(winsLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        lossesLabel.snp.makeConstraints {
            $0.leading.equalTo(drawsLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        percentageLabel.snp.makeConstraints {
            $0.leading.equalTo(lossesLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
    }

    func configure(with standing: Standings) {
        indexLabel.text = "\(standing.position)"
        teamLabel.text = standing.team.name
        matchesLabel.text = "\(standing.matches)"
        winsLabel.text = "\(standing.wins)"
        drawsLabel.text = "\(standing.draws)"
        lossesLabel.text = "\(standing.losses)"
        percentageLabel.text = "\(standing.percentage ?? 0)"
    }
}
