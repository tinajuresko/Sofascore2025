//
//  TeamSquadCell.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 05.06.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TeamSquadCell: UITableViewCell {
    private let playerImageView = AsyncImageView()
    private let playersNameLabel = UILabel()
    private let countryLabel = UILabel()
    
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
        contentView.addSubview(playerImageView)
        contentView.addSubview(playersNameLabel)
        contentView.addSubview(countryLabel)
    }
    
    private func styleViews() {
        self.backgroundColor = .white

        playerImageView.layer.cornerRadius = 20
        playerImageView.clipsToBounds = true
        
        playersNameLabel.font = .regular14
        playersNameLabel.textColor = .primaryBlack
        countryLabel.font = .regularBold12
        countryLabel.textColor = .secondaryGray
        
    }
    
    private func setupConstraints() {
        playerImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(40)
            $0.bottom.equalToSuperview().inset(8)
        }

        playersNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(playerImageView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(playersNameLabel)
            $0.top.equalTo(playersNameLabel.snp.bottom)
            $0.bottom.lessThanOrEqualToSuperview().inset(18)
            $0.height.equalTo(16)
        }
    }

    func configure(with player: Player) {
        playersNameLabel.text = player.name
        countryLabel.text = player.country?.name
        playerImageView.setImage(from: player.imageUrl)
    }
}
