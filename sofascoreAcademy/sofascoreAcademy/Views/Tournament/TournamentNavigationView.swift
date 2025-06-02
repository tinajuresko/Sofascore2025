//
//  TournamentNavigationView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TournamentNavigationView: BaseView {
    private let navigationIconImageView = UIImageView()
    private let titleLabel = UILabel()
    var onBackTapped: (() -> Void)?
    
    override func addViews() {
        super.addViews()
        addSubview(navigationIconImageView)
        addSubview(titleLabel)
    }

    override func styleViews() {
        self.backgroundColor = .headerBackground
        navigationIconImageView.image = .navigationIconWhite
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        navigationIconImageView.isUserInteractionEnabled = true
        navigationIconImageView.addGestureRecognizer(tapGesture)
        
        titleLabel.font = .regularBold20
        titleLabel.alpha = 0
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        navigationIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(navigationIconImageView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }

    func setTitleAlpha(_ alpha: CGFloat) {
        titleLabel.alpha = alpha
    }
    
    @objc private func backTapped() {
        onBackTapped?()
    }
}
