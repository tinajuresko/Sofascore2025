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
    var onBackTapped: (() -> Void)?
    
    override func addViews() {
        super.addViews()
        addSubview(navigationIconImageView)
    }

    override func styleViews() {
        self.backgroundColor = .headerBackground
        navigationIconImageView.image = .navigationIconWhite
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapped))
        navigationIconImageView.isUserInteractionEnabled = true
        navigationIconImageView.addGestureRecognizer(tapGesture)
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        
        snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        navigationIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    @objc private func backTapped() {
        onBackTapped?()
    }
}
