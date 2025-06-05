//
//  CustomHeaderView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 02.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class CustomHeaderView: BaseView {
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()
    private let imageContainerView = UIView()
    private let imageView = AsyncImageView()
    
    override func addViews() {
        super.addViews()
        addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        addSubview(countryLabel)
        addSubview(nameLabel)
    }

    override func styleViews() {
        self.backgroundColor = .headerBackground
        
        imageContainerView.backgroundColor = .white
        imageContainerView.layer.cornerRadius = 8
        imageContainerView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFit

        countryLabel.font = .regularBold14
        countryLabel.textColor = .white
        countryLabel.textAlignment = .left

        nameLabel.font = .regularBold20
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
    }
        
    override func setupConstraints() {
        super.setupConstraints()
        imageContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(56)
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageContainerView)
            $0.leading.equalTo(imageContainerView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }

        countryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(nameLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    func configure(name: String, countryName: String, imageUrl: String) {
        nameLabel.text = name
        countryLabel.text = countryName
        imageView.setImage(from: imageUrl)
    }
}
