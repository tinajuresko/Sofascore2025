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
    
    var footballTabMenuView: SportCellView?
    var basketballTabMenuView: SportCellView?
    var americanFootballTabMenuView: SportCellView?
    private var viewModel = MenuViewModel(selectedSport: .football)
    private let sportsStackView: UIStackView
    private let selectorLine = UIView()
    
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
        let football = SportType.football
        let basketball = SportType.basketball
        let americanFootball = SportType.americanFootball
        
        footballTabMenuView = SportCellView()
        footballTabMenuView?.configure(with: football)
        basketballTabMenuView = SportCellView()
        basketballTabMenuView?.configure(with: basketball)
        americanFootballTabMenuView = SportCellView()
        americanFootballTabMenuView?.configure(with: americanFootball)
        
        footballTabMenuView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectFootball)))
        basketballTabMenuView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectBasketball)))
        americanFootballTabMenuView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectAmericanFootball)))
    }
    
    func configureStackView() {
        sportsStackView.axis = .horizontal
        sportsStackView.distribution = .fillEqually
        sportsStackView.alignment = .fill
        
        if let footballTabMenuView = footballTabMenuView {
            sportsStackView.addArrangedSubview(footballTabMenuView)
        }
        if let basketballTabMenuView = basketballTabMenuView {
            sportsStackView.addArrangedSubview(basketballTabMenuView)
        }
        if let americanFootballTabMenuView = americanFootballTabMenuView {
            sportsStackView.addArrangedSubview(americanFootballTabMenuView)
        }
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
        if let footballTabMenuView = footballTabMenuView {
            selectorLine.snp.makeConstraints {
                $0.top.equalTo(footballTabMenuView.snp.bottom).offset(4)
                $0.centerX.equalTo(footballTabMenuView)
                $0.width.equalTo(footballTabMenuView).multipliedBy(0.6)
                $0.height.equalTo(4)
                $0.bottom.equalToSuperview().inset(4)
            }
        }
    }
    
    func updateSelectorPosition(for sport: SportType) {
        var selectedTabMenuView: UIView?
            
        switch sport {
        case .football:
            selectedTabMenuView = footballTabMenuView
        case .basketball:
            selectedTabMenuView = basketballTabMenuView
        case .americanFootball:
            selectedTabMenuView = americanFootballTabMenuView
        }
            
        guard let tabMenuView = selectedTabMenuView else { return }

        updateSelectorLineConstraints(tabMenuView: tabMenuView)
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
