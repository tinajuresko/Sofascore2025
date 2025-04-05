//
//  HeaderView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 02.04.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTapSettingsButton()
}

class HeaderView: BaseView {
    private let sofascoreLogoImageView = UIImageView()
    private let settingsIconImageView = UIImageView()
    private let trophyIconImageView = UIImageView()
    weak var delegate: HeaderViewDelegate?
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        super.addViews()
        configureImages()
        addSubview(sofascoreLogoImageView)
        addSubview(settingsIconImageView)
        addSubview(trophyIconImageView)
    }
    
    override func styleViews() {
        self.backgroundColor = .headerBackground
        sofascoreLogoImageView.contentMode = .scaleAspectFit
        settingsIconImageView.isUserInteractionEnabled = true
        settingsIconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsButtonTapped)))

    }
    
    @objc private func settingsButtonTapped() {
        delegate?.didTapSettingsButton()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        sofascoreLogoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(14)
        }
        
        trophyIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(sofascoreLogoImageView)
            $0.leading.greaterThanOrEqualTo(sofascoreLogoImageView.snp.trailing).offset(112)
            $0.size.equalTo(24)
        }
        
        settingsIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(trophyIconImageView)
            $0.leading.equalTo(trophyIconImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(24)
        }
    }

    func configureImages() {
        sofascoreLogoImageView.image = .sofascore
        settingsIconImageView.image = .settingsIcon
        trophyIconImageView.image = .trophyIcon
    }
}
