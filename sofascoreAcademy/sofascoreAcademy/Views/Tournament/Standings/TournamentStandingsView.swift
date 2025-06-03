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
    private let tableView = UITableView()
    private var standings: [Standings] = []
    weak var externalScrollDelegate: UIScrollViewDelegate?
    
    private var selectedSport: SportType?
    
    override func addViews() {
        super.addViews()
        addSubview(tableView)
    }

    override func styleViews() {
        backgroundColor = .containerBackground
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56
        
        setupTableView()
        setTableViewDelegates()
    }
    
    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }

        tableView.dataSource = self
        tableView.delegate = self

        SportType.allCases
            .map { StandingsCellType.from(sport: $0) }
            .forEach { $0.registerCell(on: tableView) }
    }

    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(standings: [Standings], sport: SportType) {
        self.standings = standings
        selectedSport = sport
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension TournamentStandingsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        standings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sport = selectedSport
        let cellType = StandingsCellType.from(sport: sport ?? .football)
        let standing = standings[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath)

        switch cell {
        case let footballCell as FootballStandingsCell:
            footballCell.configure(with: standing)
            return footballCell
        case let basketballCell as BasketballStandingsCell:
            basketballCell.configure(with: standing)
            return basketballCell
        case let amFootballCell as AmFootballStandingsCell:
            amFootballCell.configure(with: standing)
            return amFootballCell
        default:
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sport = selectedSport
        switch sport {
        case .football:
            return FootballHeaderView()
        case .basketball:
            return BasketballHeaderView()
        case .americanFootball:
            return AmFootballHeaderView()
        case .none:
            return nil
        }
    }
}

// MARK: UIScrollViewDelegate
extension TournamentStandingsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        externalScrollDelegate?.scrollViewDidScroll?(scrollView)
    }
}
