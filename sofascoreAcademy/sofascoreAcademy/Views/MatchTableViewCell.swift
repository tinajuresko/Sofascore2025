//
//  MatchTableViewCell.swift
//  hw3
//
//  Created by Tina Jureško on 20.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

protocol MatchTableCellDelegate: AnyObject {
    func didTapEvent(selectedEvent: EventDetailsViewModel)
}

class MatchTableViewCell: UITableViewCell {
    private let matchView = MatchView()
    weak var delegate: MatchTableCellDelegate?
    private var event: MatchViewModel?
    private var selectedEvent: EventDetailsViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(matchView)
        self.backgroundColor = .clear
        
        
        matchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eventCellTapped)))
        
        matchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(56)
        }
    }

    @objc private func eventCellTapped() {
        if let selectedEvent = selectedEvent {
            delegate?.didTapEvent(selectedEvent: selectedEvent)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MatchViewModel) {
        self.event = viewModel
        matchView.configure(with: viewModel)
        
        self.selectedEvent = EventDetailsViewModel(event: viewModel.event)
    }
}

