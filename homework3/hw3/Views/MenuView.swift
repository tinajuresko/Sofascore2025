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
    
    var footballCell: SportCellView?
    var basketballCell: SportCellView?
    var americanFootballCell: SportCellView?
    private let viewModel = MenuViewModel(selectedSport: .football)
    private let sportsStackView: UIStackView
    private let selectorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init() {
        self.sportsStackView = UIStackView()
        super.init()
    }
    
    override func addViews() {
        super.addViews()
        
        configureSportCells()
        configureStackView()
        addSubview(sportsStackView)
        addSubview(selectorLine)
        
        viewModel.onSportSelectionChanged = { [weak self] selectedSport in
            self?.updateSelectorPosition(for: selectedSport)
        }
    }
    
    func configureSportCells() {
        guard let footballIcon = UIImage(named: "icon_football"),
              let basketballIcon = UIImage(named: "icon_basketball"),
              let americanFootballIcon = UIImage(named: "icon_american_football")
        else {
            print("Missing icon(s)")
            return
        }
        
        footballCell = SportCellView(sportIcon: footballIcon, sportName: "Football")
        basketballCell = SportCellView(sportIcon: basketballIcon, sportName: "Basketball")
        americanFootballCell = SportCellView(sportIcon: americanFootballIcon, sportName: "American football")
        
        footballCell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectFootball)))
        basketballCell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectBasketball)))
        americanFootballCell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectAmericanFootball)))
    }
    
    func configureStackView() {
        sportsStackView.axis = .horizontal
        sportsStackView.distribution = .fillEqually
        sportsStackView.alignment = .fill
        
        if let footballCell = footballCell {
            sportsStackView.addArrangedSubview(footballCell)
        }
        if let basketballCell = basketballCell {
            sportsStackView.addArrangedSubview(basketballCell)
        }
        if let americanFootballCell = americanFootballCell {
            sportsStackView.addArrangedSubview(americanFootballCell)
        }
    }
    
    override func styleViews() {
        self.backgroundColor = AppStyles.Colors.headerBackgroundColor
        selectorLine.backgroundColor = .white
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        sportsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(4)
        }
        if let footballCell = footballCell {
            selectorLine.snp.makeConstraints {
                $0.top.equalTo(footballCell.snp.bottom).offset(4)
                $0.centerX.equalTo(footballCell)
                $0.width.equalTo(footballCell).multipliedBy(0.6)
                $0.height.equalTo(4)
                $0.bottom.equalToSuperview().inset(4)
            }
        }
    }
    
    func updateSelectorPosition(for sport: SportType) {
        var selectedCell: UIView?
            
        switch sport {
        case .football:
            selectedCell = footballCell
        case .basketball:
            selectedCell = basketballCell
        case .americanFootball:
            selectedCell = americanFootballCell
        }
            
        guard let cell = selectedCell else { return }

        UIView.animate(withDuration: 0.3) {
            self.selectorLine.snp.remakeConstraints {
                $0.top.equalTo(cell.snp.bottom).offset(4)
                $0.centerX.equalTo(cell)
                $0.width.equalTo(cell).multipliedBy(0.6)
                $0.height.equalTo(4)
                $0.bottom.equalToSuperview().inset(4)
            }
            self.layoutIfNeeded()
        }
    }
        
    @objc func selectFootball() {
        viewModel.selectSport(.football)
    }
        
    @objc func selectBasketball() {
        viewModel.selectSport(.basketball)
    }
        
    @objc func selectAmericanFootball() {
        viewModel.selectSport(.americanFootball)
    }
}
