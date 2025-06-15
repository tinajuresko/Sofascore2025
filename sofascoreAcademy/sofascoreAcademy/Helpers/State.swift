//
//  State.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 30.05.2025..
//

import Foundation

enum State<T> {
    case idle
    case loaded(T)
    case loading
    case error
}

extension State {
    var isIdleOrError: Bool {
        switch self {
        case .idle, .error:
            return true
        default:
            return false
        }
    }
}
