//
//  LeagueHeaderView.swift
//  hw3
//
//  Created by Tina Jureško on 20.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

protocol LeagueHeaderViewDelegate: AnyObject {
    func didTapLeague(_ league: League)
}

class LeagueHeaderView: UITableViewHeaderFooterView {

    private let leagueView = LeagueView()
    weak var delegate: LeagueHeaderViewDelegate?
    private var league: League?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leagueView)
        
        leagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        leagueView.addGestureRecognizer(tapGesture)
        leagueView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap() {
        if let league = league {
            delegate?.didTapLeague(league)
        }
    }
    
    func configure(with league: League) {
        self.league = league
        leagueView.setCountryLabel(league.country?.name)
        leagueView.setNameLabel(league.name)
        leagueView.setLogoImageView(league.logoUrl)
    }
}

