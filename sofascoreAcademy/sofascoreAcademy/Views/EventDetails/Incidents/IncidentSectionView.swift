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
        
    func configure(with incidents: [Incident], status: EventStatus) {
        self.viewModel = IncidentSectionViewModel(incidents: incidents, status: status)
        incidentsTableView.reloadData()
    }
    
    private func makeHeaderView(for period: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = .periodContainerBackground
        container.layer.cornerRadius = 16
        container.clipsToBounds = true
        container.snp.makeConstraints { $0.height.equalTo(24) }

        let label = UILabel()
        label.font = .regularBold12
        label.textColor = .primaryBlack
        label.textAlignment = .center
        label.text = self.periodTitle(for: period)

        container.addSubview(label)
        container.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }

        return container
    }

    private func periodTitle(for number: Int) -> String {
        switch number {
        case 1: return "First half"
        case 2: return "Second half"
        case 3: return "Extra time – First half"
        case 4: return "Extra time – Second half"
        case 5: return "Penalties"
        default: return "Period \(number)"
        }
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
            cell.configure(with: incident)
            return cell
        }
    }
}

