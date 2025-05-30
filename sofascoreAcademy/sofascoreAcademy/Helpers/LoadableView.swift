//
//  LoadableView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 30.05.2025..
//

import Foundation
import UIKit

protocol LoadableView {
    var activityIndicator: UIActivityIndicatorView { get }
    var errorLabel: UILabel { get }

    func showLoadingState()
    func showErrorState(message: String)
    func hideError()
    func showLoadedState()
    
    func handleState<T>(_ state: State<T>,
                        onLoading: () -> Void,
                        onLoaded: (T) -> Void,
                        onError: () -> Void,
                        onIdle: (() -> Void)?)
}

extension LoadableView {
    func showLoadingState() {
        activityIndicator.startAnimating()
        hideError()
    }
    
    func showErrorState(message: String = "No data available.") {
        activityIndicator.stopAnimating()
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    func showLoadedState() {
        activityIndicator.stopAnimating()
        hideError()
    }
    
    func handleState<T>(_ state: State<T>,
                        onLoading: () -> Void,
                        onLoaded: (T) -> Void,
                        onError: () -> Void,
                        onIdle: (() -> Void)? = nil) {
        switch state {
        case .idle:
            onIdle?()
        case .loading:
            onLoading()
        case .loaded(let data):
            onLoaded(data)
        case .error:
            onError()
        }
    }
}
