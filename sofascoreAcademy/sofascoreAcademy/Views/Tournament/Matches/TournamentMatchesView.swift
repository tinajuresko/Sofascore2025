//
//  TournamentMatchesView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic
import Combine

class TournamentMatchesView: BaseView {
    private let tableView = UITableView()
    private var viewModel: TournamentMatchesViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    var scrollView: UIScrollView {
        return tableView
    }
    
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
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
    }
        
    override func setupConstraints() {
        super.setupConstraints()

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with viewModel: TournamentMatchesViewModel) {
        self.viewModel = viewModel
        observeViewModel()
    }

    private func observeViewModel() {
        viewModel.$groupedMatches
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension TournamentMatchesView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.groupedMatches.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys =  viewModel.sortedKeys
        let key = sortedKeys[section]
        return (viewModel?.groupedMatches[key]?.count ?? 0) + 1 // +1 -> header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sortedKeys =  viewModel.sortedKeys
        let roundKey = sortedKeys[indexPath.section]

        if indexPath.row == 0 {
            // Header cell
            let cell = UITableViewCell()
            cell.backgroundColor = .clear 
            cell.selectionStyle = .none
            let label = UILabel()
            label.font = .regularBold14
            label.textColor = .primaryBlack
            label.text = "Round \(roundKey)"
            cell.contentView.addSubview(label)
            label.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.top.bottom.equalToSuperview().offset(24)
                $0.bottom.equalToSuperview().inset(8)
            }
            return cell
        } else {
            guard let match = viewModel.groupedMatches[roundKey]?[indexPath.row - 1] else {
                return UITableViewCell()
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchTableViewCell else {
                return UITableViewCell()
            }
            let matchViewModel = MatchViewModel(event: match)
            cell.configure(with: matchViewModel)
            return cell
        }
    }
}
