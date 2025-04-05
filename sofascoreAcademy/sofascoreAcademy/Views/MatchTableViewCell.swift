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
    func didTapEvent(event: MatchViewModel)
}

class MatchTableViewCell: UITableViewCell {
    private let matchView = MatchView()
    weak var delegate: MatchTableCellDelegate?
    private var event: MatchViewModel?
    
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
        if let event = event {
            delegate?.didTapEvent(event: event) 
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MatchViewModel) {
        self.event = viewModel
        matchView.configure(with: viewModel)
    }
}

