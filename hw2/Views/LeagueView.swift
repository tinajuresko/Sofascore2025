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
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LaLiga")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override func addViews() {
        super.addViews()
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(arrowImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        arrowImageView.contentMode = .scaleAspectFit
        
        countryLabel.font = .regularBold14()
        countryLabel.textColor = AppStyles.Colors.primary
        countryLabel.numberOfLines = 0
        countryLabel.lineBreakMode = .byWordWrapping
        
        nameLabel.font = .regularBold14()
        nameLabel.textColor = AppStyles.Colors.secondary
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(32)
        }
        
        countryLabel.snp.makeConstraints {
            $0.centerY.equalTo(logoImageView)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(countryLabel)
            $0.leading.equalTo(countryLabel.snp.trailing).offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(arrowImageView)
            $0.leading.equalTo(arrowImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    func countryLabel(_ text: String) {
        countryLabel.text = text
    }
    
    func nameLabel(_ name: String) {
        nameLabel.text = name
    }
}
