//
//  CustomTabsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

enum TabType {
    case matches
    case standings
    case details
    case squad
    
    var title: String {
        switch self {
        case .matches: return "Matches"
        case .standings: return "Standings"
        case .details: return "Details"
        case .squad: return "Squad"
        }
    }
}

class CustomTabsView: BaseView {
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let selectorLine = UIView()
    
    private var selectedIndex: Int = 0
    private var selectorLineConstraints: Constraint?
    var onTabSelected: ((TabType) -> Void)?
    
    private var firstTab: TabType = .matches
    private var secondTab: TabType = .standings
    
    override func addViews() {
        super.addViews()
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(selectorLine)
    }

    override func styleViews() {
        self.backgroundColor = .headerBackground
        
        firstLabel.font = .regular14
        firstLabel.textColor = .white
        firstLabel.textAlignment = .center
        
        secondLabel.font = .regular14
        secondLabel.textColor = .white
        secondLabel.textAlignment = .center
        
        selectorLine.backgroundColor = .white
    }
        
    override func setupConstraints() {
        super.setupConstraints()
    
        firstLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
            
        secondLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        selectorLine.snp.makeConstraints {
            selectorLineConstraints = $0.centerX.equalTo(firstLabel).constraint
            $0.leading.equalTo(firstLabel).offset(8)
            $0.trailing.equalTo(firstLabel).inset(8)
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    func configure(firstTab: TabType, secondTab: TabType) {
        self.firstTab = firstTab
        self.secondTab = secondTab
        firstLabel.text = firstTab.title
        secondLabel.text = secondTab.title

        firstLabel.isUserInteractionEnabled = true
        firstLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(firstTapped)))

        secondLabel.isUserInteractionEnabled = true
        secondLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(secondTapped)))
    }
    
    @objc private func firstTapped() {
        moveSelector(to: 0)
        onTabSelected?(firstTab)
    }

    @objc private func secondTapped() {
        moveSelector(to: 1)
        onTabSelected?(secondTab)
    }
    
    private func moveSelector(to index: Int) {
        guard index != selectedIndex else { return }
        selectedIndex = index

        let targetView = (index == 0) ? firstLabel : secondLabel

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
