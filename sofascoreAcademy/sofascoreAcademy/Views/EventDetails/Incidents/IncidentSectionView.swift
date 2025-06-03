//
//  IncidentSectionView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 26.05.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class IncidentSectionView: BaseView {
    private let stackView = UIStackView()
    private let incidentsTableView: UITableView = .init()
    private var incidents: [Incident] = []
    private var sections: [(period: Int, incidents: [Incident])] = []
    
    private var viewModel: IncidentSectionViewModel?
    private var selectedSport: SportType?
    
    override func addViews() {
        super.addViews()
        addSubview(stackView)
        stackView.addArrangedSubview(incidentsTableView)
    }
        
    override func styleViews() {
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 8
        
        incidentsTableView.separatorStyle = .none
        incidentsTableView.backgroundColor = .clear
        setTableViewDelegates()
        setupTableView(incidentsTableView: incidentsTableView)
    }
       
    func setTableViewDelegates() {
        incidentsTableView.delegate = self
        incidentsTableView.dataSource = self
    }
    
    func setupTableView(incidentsTableView: UITableView) {
        incidentsTableView.register(IncidentCell.self, forCellReuseIdentifier: "IncidentCell")
        incidentsTableView.register(IncidentPeriodHeaderCell.self, forCellReuseIdentifier: "IncidentPeriodHeaderCell")
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
        
    func configure(with incidents: [Incident], status: EventStatus, selectedSport: SportType) {
        self.viewModel = IncidentSectionViewModel(incidents: incidents, status: status)
        self.selectedSport = selectedSport
        incidentsTableView.tableHeaderView = makeTableHeaderSpacer(height: 8)
        incidentsTableView.reloadData()
    }
    
    private func makeTableHeaderSpacer(height: CGFloat) -> UIView {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        spacer.frame = CGRect(x: 0, y: 0, width: 1, height: height)
        return spacer
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension IncidentSectionView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.sections[section].incidents.count ?? 0) + 1 // +1 za header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let sectionData = viewModel.sections[indexPath.section]

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentPeriodHeaderCell", for: indexPath) as? IncidentPeriodHeaderCell else {
                return UITableViewCell()
            }

            let title = viewModel.title(for: sectionData)
            let color = viewModel.titleColor
            cell.configure(with: title, and: color)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentCell", for: indexPath) as? IncidentCell else {
                return UITableViewCell()
            }

            let incident = sectionData.incidents[indexPath.row - 1] // -1 jer je header na indexu 0
            cell.configure(with: incident, for: selectedSport ?? .football)
            return cell
        }
    }
}
