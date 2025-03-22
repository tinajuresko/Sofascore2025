//
//  ViewController.swift
//  hw2
//
//  Created by Tina Jureško on 14.03.2025..
//

import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {

    private let leagueView = LeagueView()
    
    private let matchesVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBackgroundColor")
        
        view.addSubview(leagueView)
        leagueView.translatesAutoresizingMaskIntoConstraints = false
        leagueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).inset(16)
            $0.height.equalTo(56)
        }
        
        view.addSubview(matchesVerticalStackView)
        matchesVerticalStackView.snp.makeConstraints {
            $0.top.equalTo(leagueView.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }

        
        let league = Homework2DataSource().laLigaLeague()
        leagueView.countryLabel(league.country?.name ?? "Unkown")
        leagueView.nameLabel(league.name)
        
        let events = Homework2DataSource().laLigaEvents()
        for event in events {
            let matchView = MatchView()
            let viewModel = MatchViewModel(event: event)
            matchView.configure(with: viewModel)
            
            matchesVerticalStackView.addArrangedSubview(matchView)
            
            matchView.snp.makeConstraints {
                $0.height.equalTo(56)
            }
        }
    }
}

