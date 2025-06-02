//
//  TournamentStandingsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TournamentStandingsView: BaseView {
    private let label = UILabel()
    
    override func addViews() {
        super.addViews()
        addSubview(label)
    }

    override func styleViews() {
        self.backgroundColor = .white
        
        label.text = "Standings"
        label.font = .regular14
        label.textColor = .primaryBlack
    }
        
    override func setupConstraints() {
        super.setupConstraints()

        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
