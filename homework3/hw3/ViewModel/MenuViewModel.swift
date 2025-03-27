//
//  MenuViewModel.swift
//  hw3
//
//  Created by Tina Jureško on 19.03.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit


struct MenuViewModel {
    var selectedSport: SportType
    var onSportSelectionChanged: ((SportType) -> Void)?
    
    init(selectedSport: SportType) {
        self.selectedSport = selectedSport
    }
    
    mutating func selectSport(_ sport: SportType) {
        self.selectedSport = sport
        
        onSportSelectionChanged?(sport)
    }
    
    func getSportCell(for sport: SportType) -> UIView? {
        switch sport {
        case .football:
            return MenuView().footballTabMenuView
        case .basketball:
            return MenuView().basketballTabMenuView
        case .americanFootball:
            return MenuView().americanFootballTabMenuView
        }
    }
}
