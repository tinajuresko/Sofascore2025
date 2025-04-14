//
//  MenuView.swift
//  hw3
//
//  Created by Tina Jureško on 19.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class MenuView: BaseView {
    let tabMenuView: SportCellView? = SportCellView()
    private let sportsStackView: UIStackView = UIStackView()
    private let selectorLine = UIView()
    
    override init() {
        super.init()
    }
    
    override func addViews() {
        super.addViews()
        configureSportCells()
        configureStackView()
        addSubview(sportsStackView)
        addSubview(selectorLine)
        
        SportSelectionManager.shared.onSportSelectionChanged = { [weak self] selectedSport in
            self?.updateSelectorPosition(for: selectedSport)
        }
    }
    
    func configureSportCells() {
        for (index, sport) in SportType.allCases.enumerated() {
            let sportCellView = SportCellView()
            sportCellView.configure(with: sport)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectSportAction(_:)))
            sportCellView.tag = index
            sportCellView.addGestureRecognizer(tapGesture)
                    
            sportsStackView.addArrangedSubview(sportCellView)
        }
    }
    
    @objc func selectSportAction(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        let selectedSport = SportType.allCases[view.tag]
        SportSelectionManager.shared.selectSport(selectedSport)
    }
    
    func configureStackView() {
        sportsStackView.axis = .horizontal
        sportsStackView.distribution = .fillEqually
        sportsStackView.alignment = .fill
    }
    
    override func styleViews() {
        self.backgroundColor = .headerBackground
        selectorLine.backgroundColor = .white
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        sportsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(4)
        }
        guard let firstTabMenuView = sportsStackView.arrangedSubviews.first else {
            return
        }
        selectorLine.snp.makeConstraints {
            $0.top.equalTo(firstTabMenuView.snp.bottom).offset(4)
            $0.centerX.equalTo(firstTabMenuView)
            $0.width.equalTo(firstTabMenuView)
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview().inset(4)
        }
    }
    
    func updateSelectorPosition(for sport: SportType) {
        if let selectedTabMenuView = sportsStackView.arrangedSubviews.first(where: {
            ($0 as? SportCellView)?.tag == sportToIndex(sport: sport)
        }) {
            updateSelectorLineConstraints(tabMenuView: selectedTabMenuView)
        }
    }
    
    func updateSelectorLineConstraints(tabMenuView: UIView) {
        UIView.animate(withDuration: 0.3) {
            self.selectorLine.snp.remakeConstraints {
                $0.top.equalTo(tabMenuView.snp.bottom).offset(4)
                $0.centerX.equalTo(tabMenuView)
                $0.width.equalTo(tabMenuView)
                $0.height.equalTo(4)
                $0.bottom.equalToSuperview().inset(4)
            }
            self.layoutIfNeeded()
        }
    }
    
    private func sportToIndex(sport: SportType) -> Int {
        return SportType.allCases.firstIndex(of: sport) ?? 0
    }
}
