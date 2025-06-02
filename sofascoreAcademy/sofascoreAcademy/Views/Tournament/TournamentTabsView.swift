//
//  TournamentTabsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

enum LeagueTabType {
    case matches
    case standings
}

class TournamentTabsView: BaseView {
    private let matchesLabel = UILabel()
    private let standingsLabel = UILabel()
    private let selectorLine = UIView()
    
    private var selectedIndex: Int = 0
    private var selectorLineConstraints: Constraint?
    var onTabSelected: ((LeagueTabType) -> Void)?
    
    override init() {
        super.init()
        configure()
    }
    
    override func addViews() {
        super.addViews()
        addSubview(matchesLabel)
        addSubview(standingsLabel)
        addSubview(selectorLine)
    }

    override func styleViews() {
        self.backgroundColor = .headerBackground
        
        matchesLabel.font = .regular14
        matchesLabel.textColor = .white
        matchesLabel.textAlignment = .center
        
        standingsLabel.font = .regular14
        standingsLabel.textColor = .white
        standingsLabel.textAlignment = .center
        
        selectorLine.backgroundColor = .white
    }
        
    override func setupConstraints() {
        super.setupConstraints()
    
        matchesLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
            
        standingsLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        selectorLine.snp.makeConstraints {
            selectorLineConstraints = $0.centerX.equalTo(matchesLabel).constraint
            $0.leading.equalTo(matchesLabel).offset(8)
            $0.trailing.equalTo(matchesLabel).inset(8)
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    func configure() {
        matchesLabel.text = "Matches"
        standingsLabel.text = "Standings"
        
        let matchesTap = UITapGestureRecognizer(target: self, action: #selector(matchesTapped))
        matchesLabel.addGestureRecognizer(matchesTap)
        matchesLabel.isUserInteractionEnabled = true

        let standingsTap = UITapGestureRecognizer(target: self, action: #selector(standingsTapped))
        standingsLabel.addGestureRecognizer(standingsTap)
        standingsLabel.isUserInteractionEnabled = true
    }
    
    @objc private func matchesTapped() {
        moveSelector(to: 0)
        onTabSelected?(.matches)
    }

    @objc private func standingsTapped() {
        moveSelector(to: 1)
        onTabSelected?(.standings)
    }
    
    private func moveSelector(to index: Int) {
        guard index != selectedIndex else { return }
        selectedIndex = index

        let targetView = (index == 0) ? matchesLabel : standingsLabel

        selectorLine.snp.remakeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.centerX.equalTo(targetView)
            $0.leading.equalTo(targetView).offset(8)
            $0.trailing.equalTo(targetView).inset(8)
            $0.height.equalTo(4)
        }

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
