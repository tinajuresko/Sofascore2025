//
//  NoResultsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 26.05.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class NoResultsView: BaseView {
    private let contentView = UIView()
    private let resultsView = UIView()
    private let resultsLabel = UILabel()
    private let viewTournamentsButton = UIButton()
    
    override func addViews() {
        super.addViews()
        addSubview(contentView)
        contentView.addSubview(resultsView)
        resultsView.addSubview(resultsLabel)
        contentView.addSubview(viewTournamentsButton)
    }
    
    override func styleViews() {
        contentView.backgroundColor = .white
        
        resultsView.backgroundColor = .containerBackground
        resultsView.layer.cornerRadius = 6

        resultsLabel.font = .regular14
        resultsLabel.text = "No results yet."
        resultsLabel.textColor = .secondaryGray
        resultsLabel.textAlignment = .center

        viewTournamentsButton.setTitle("View Tournament Details", for: .normal)
        viewTournamentsButton.titleLabel?.font = .regularBold14
        viewTournamentsButton.setTitleColor(.headerBackground, for: .normal)
        viewTournamentsButton.layer.borderColor = UIColor.headerBackground.cgColor
        viewTournamentsButton.layer.borderWidth = 2
    }
    
    override func setupConstraints() {
        super.setupConstraints()

        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(148)
        }
        
        resultsView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview().inset(layoutMargins.left)
            $0.height.equalTo(52)
        }

        resultsLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        viewTournamentsButton.snp.makeConstraints {
            $0.top.equalTo(resultsView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(layoutMargins.left + 74)
            $0.height.equalTo(40)
        }
    }
}
