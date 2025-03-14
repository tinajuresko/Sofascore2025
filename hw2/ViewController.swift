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
    //private let matchView = MatchView()
    
    private let matchesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(leagueView)
        leagueView.translatesAutoresizingMaskIntoConstraints = false
        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(56)
        }
        
        view.addSubview(matchesStackView)
        matchesStackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }

        
        let league = Homework2DataSource().laLigaLeague()
        leagueView.configure(league: league)
        
        let events = Homework2DataSource().laLigaEvents()
        for event in events {
            let matchView = MatchView()
            let viewModel = MatchViewModel(event: event)
            matchView.configure(viewModel: viewModel)
            
            matchesStackView.addArrangedSubview(matchView)
            
            matchView.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
        }
    }
}

