//
//  SportSelectionManager.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 14.04.2025..
//

import Foundation
import SofaAcademic

final class SportSelectionManager {
    static let shared = SportSelectionManager(selectedSport: .football)
    
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
