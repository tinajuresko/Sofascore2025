//
//  LeagueView.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LeagueView: BaseView {
    
    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let nameLabel = UILabel()
        
    override func addViews() {
        super.addViews()
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(arrowImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        super.styleViews()
        
        StylingHelper.styleImageView(imageView: logoImageView, imageName: "LaLiga")
        StylingHelper.styleImageView(imageView: arrowImageView, imageName: "Vector")
        if let boldFont = AppStyles.Fonts.bold(size: 14) {
            StylingHelper.styleLabel(label: countryLabel, font: boldFont, color: AppStyles.Colors.primary ?? .black)
            StylingHelper.styleLabel(label: nameLabel, font: boldFont, color: AppStyles.Colors.secondary ?? .gray)
        }
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(logoImageView.snp.right).offset(32)
            make.height.equalTo(24)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(countryLabel)
            make.left.equalTo(countryLabel.snp.right).offset(10)
            make.height.equalTo(5)
            make.width.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(arrowImageView.snp.right).offset(10)
            make.height.equalTo(24)
        }
    }
        
    func configure(league: League) {
        countryLabel.text = league.country?.name ?? "Unknown"
        nameLabel.text = league.name
    }
}
