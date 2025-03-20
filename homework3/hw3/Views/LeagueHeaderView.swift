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

class LeagueHeaderView: UITableViewHeaderFooterView {

    private let leagueView = LeagueView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(leagueView)
        
        leagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with league: League?) {
        leagueView.setCountryLabel(league?.country?.name ?? "Unknown")
        leagueView.setNameLabel(league?.name ?? "Unknown League")
        leagueView.setLogoImageView(league?.name ?? "Unknown League")
    }
}

