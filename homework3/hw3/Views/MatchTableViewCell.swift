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

class MatchTableViewCell: UITableViewCell {
    private let matchView = MatchView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(matchView)
        self.backgroundColor = .clear
        matchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(56)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: MatchViewModel) {
        matchView.configure(with: viewModel)
    }
}

