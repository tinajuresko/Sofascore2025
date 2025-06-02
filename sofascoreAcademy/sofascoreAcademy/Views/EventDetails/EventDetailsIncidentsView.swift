//
//  EventDetailsIncidentsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 26.05.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class EventDetailsIncidentsView: BaseView {
    private let stackView = UIStackView()
    private let sectionView = IncidentSectionView()
    
    override func addViews() {
        super.addViews()
        addSubview(stackView)
    }
    
    override func styleViews() {
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 4
        
        sectionView.backgroundColor = .clear
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with incidents: [Incident], status: EventStatus) {
        DispatchQueue.main.async {
            self.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            switch status {
            case .notStarted:
                let noResultsView = NoResultsView()
                self.stackView.addArrangedSubview(noResultsView)
            default:
                self.sectionView.configure(with: incidents, status: status)
                self.stackView.addArrangedSubview(self.sectionView)
            }
        }
    }
}
