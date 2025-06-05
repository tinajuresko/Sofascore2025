//
//  TournamentCell.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.06.2025..
//

import Foundation
import UIKit
import SnapKit

class TournamentCell: UICollectionViewCell {
    let imageView = AsyncImageView()
    let nameLabel = UILabel()
    let stack = UIStackView()

    override init(frame: CGRect) {
            super.init(frame: frame)
            addViews()
            styleViews()
            setupConstraints()
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(nameLabel)
        contentView.addSubview(stack)
    }
    
    private func styleViews() {
        imageView.contentMode = .scaleAspectFit
        nameLabel.font = .regular14
        nameLabel.textColor = .secondaryGray
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byWordWrapping
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 4
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }

    func configure(with tournament: League) {
        nameLabel.text = tournament.name
        imageView.setImage(from: tournament.logoUrl)
    }
}
