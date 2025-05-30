//
//  IncidentPeriodHeaderCell.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 27.05.2025..
//

import Foundation
import UIKit
import SnapKit

class IncidentPeriodHeaderCell: UITableViewCell {

    private let container = UIView()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addViews() {
        contentView.addSubview(container)
        container.addSubview(titleLabel)
    }
    
    private func styleViews() {
        selectionStyle = .none
        backgroundColor = .clear

        container.backgroundColor = .periodContainerBackground
        container.layer.cornerRadius = 16
        container.clipsToBounds = true
        
        titleLabel.font = .regularBold12
        titleLabel.textColor = .primaryBlack
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
            $0.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.lessThanOrEqualTo(160)
        }
    }

    func configure(with title: String, and color: UIColor) {
        titleLabel.text = title
        titleLabel.textColor = color
    }
}
