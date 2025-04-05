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


class MenuViewModel {
    static let shared = MenuViewModel(selectedSport: .football) 
    
    private(set) var selectedSport: SportType
    var onSportSelectionChanged: ((SportType) -> Void)?
    
    private init(selectedSport: SportType) {
        self.selectedSport = selectedSport
    }
    
    func selectSport(_ sport: SportType) {
        self.selectedSport = sport
        onSportSelectionChanged?(sport)
    }
}

