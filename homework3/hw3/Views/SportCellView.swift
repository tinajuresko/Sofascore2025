//
//  SportCellView.swift
//  hw3
//
//  Created by Tina Jureško on 19.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class SportCellView: BaseView {
    private let sportIconImageView: UIImageView
    private let sportNameLabel: UILabel
    private let sportIcon: UIImage
    private let sportName: String
    
    init(sportIcon: UIImage, sportName: String){
        self.sportIcon = sportIcon
        self.sportName = sportName
        self.sportIconImageView = UIImageView(image: sportIcon)
        self.sportNameLabel = UILabel()
        self.sportNameLabel.text = sportName
        super.init()
    }
    
    override func addViews() {
        addSubview(sportIconImageView)
        addSubview(sportNameLabel)
    }
    
    override func styleViews() {
        sportNameLabel.textAlignment = .center
        sportNameLabel.setStyle(.regular14)
        sportNameLabel.textColor = .white
        sportIconImageView.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        sportIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        sportNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sportIconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
    }
}
