//
//  Date+Extensions.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 11.04.2025..
//

import Foundation

extension Date {
    var dayMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }

    var hourMinute: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func elapsedMinutes(from date: Date) -> Int {
        return Int(self.timeIntervalSince(date)) / 60
    }
}

extension Int {
    var asDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
