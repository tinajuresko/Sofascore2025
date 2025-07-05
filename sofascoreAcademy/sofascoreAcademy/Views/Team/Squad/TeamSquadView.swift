//
//  TeamSquadView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 05.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class TeamSquadView: BaseView {

    private let tableView = UITableView()
    private var players: [Player] = []
    weak var externalScrollDelegate: UIScrollViewDelegate?

    override func addViews() {
        super.addViews()
        addSubview(tableView)
    }
    
    override func styleViews() {
        backgroundColor = .containerBackground
        tableView.backgroundColor = .clear

        setupTableView()
        setTableViewDelegates()
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(TeamSquadCell.self, forCellReuseIdentifier: "TeamSquadCell")
    }
    
    func configure(players: [Player]) {
        self.players = players
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension TeamSquadView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamSquadCell", for: indexPath) as? TeamSquadCell else {
            return UITableViewCell()
        }
        cell.configure(with: players[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white

        let label = UILabel()
        label.text = "Players"
        label.font = .regularBold14
        label.textColor = .primaryBlack

        headerView.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        return headerView
    }
}

// MARK: UIScrollViewDelegate
extension TeamSquadView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        externalScrollDelegate?.scrollViewDidScroll?(scrollView)
    }
}
